# stup

A CLI tool to easily save, access and organize daily notes.

![Version badge](https://img.shields.io/badge/version-0.1.1-green.svg)  
<!-- ALL-CONTRIBUTORS-BADGE:START - Do not remove or modify this section -->
[![All Contributors](https://img.shields.io/badge/all_contributors-1-orange.svg?style=flat-square)](#contributors-)
<!-- ALL-CONTRIBUTORS-BADGE:END -->

The name derives from the [**St**and**up**](https://en.wikipedia.org/wiki/Stand-up_meeting) meetings since its initial purpose was to cover my need for keeping my Standup notes in a convenient way.

![stup Gif demo](https://raw.githubusercontent.com/iridakos/stup/master/assets/stup-0-1-0.gif)

## How it works

Notes are organized in **categories**.

When a new note is added, `stup` creates a markdown file and places it under the category's directory in a sub-directory with a path based on the date.

```bash
CATEGORIES_ROOT_DIRECTORY/CATEGORY/YEAR/MONTH/YYYY-MM-DD.md

# For example, the notes of a category named "programming" April 18th, 2020 are saved under
CATEGORIES_ROOT_DIRECTORY/programming/2020/04/2020-04-18.md
```

This allows users to retrieve any notes added on a specific date or in a specific period for a specific or for all categories.

```bash
# Fetch notes for all categories
$ stup show @ 2020-04-18

# Fetch notes for a specific category for previous week
$ stup log previous-week -c programming

# Fetch notes for all categories for a specific period
$ stup log --from 2020-04-01 --to 2020-04-15
```

## Installation

For the moment, the installation is manual until [this issue](https://github.com/iridakos/stup/issues/6) is resolved.

So you have to clone the repository and place the executable `stup` script in a directory included in your `$PATH` variable.

```bash
git clone https://github.com/iridakos/stup

cd stup

# Given that `~/.local/bin` is included in your $PATH variable
cp ./stup ~/.local/bin
```

## Configuration

Before you start using `stup` you have to configure it with:

```bash
stup --configure
```

Follow the wizard to define:

* to which directory `stup` will be saving your notes
* what is the name of the default category \*
* what is the editor you want to use to manually edit your notes when using the `edit` command

**\*** You can use `stup` with just a default category but in case you want to add your notes structured for example per project or per any type of section you want, you have the option to create and use multiple categories (see below).

## Usage

### Add notes

To add a new note use the `add` command.

```bash
$ stup add @ yesterday -n "A note" -n "Another note"
```

The full version of the command:

```bash
stup add @|--at|-@ <when> -n|--note "<note text>" -c|--category "<category-name>"
```

where:
  * `<when>`: specifies in which date the notes should be added. Its value can be:
    * any of the words: `today`, `tomorrow`, `yesterday` in which case you can omit the `@`|`--at`|`-@` option
    * a date string in the form: `YYYY-MM-DD`, for example: 2020-04-12
    * **if you omit this option, `stup` by default will save the notes in the current date**
  * `<note-text>`: the text of the note, for example: "Reviewed PR related to..."
  * `-c` or `--category`: is the category option (optional). **If omitted, notes will be saved to your default category**
    * `<category-name>`: the name of the category in which the notes will be added

#### Examples

##### Add a note for current date (all of the following commands are equivalent)

```bash
# Implying today (if you don't define the date, the add action defaults to current date)
$ stup add -n "A new note"

# Explicit with date alias 'today' ommiting the `@` option
$ stup add today -n "A new note"

# Explicit with date alias 'today'
$ stup add @ today -n "A new note"

# Explicit without the 'today' alias (suppose the date is April 17th, 2020)
$ stup add @ 2020-04-17 -n "A new note"
```

##### Add a note for yesterday

All of the following commands are equivalent.

```bash
# Explicit with date alias 'yesteday'
$ stup add @ yesteday -n "A new note"

# Explicit with date alias ommiting the `@` option
$ stup add yesteday -n "A new note"

# Explicit without alias (suppose the date is April 17th, 2020)
$ stup add @ 2020-04-16 -n "A new note"
```

##### Add a note for tomorrow

All of the following commands are equivalent.

```bash
# Explicit with date alias 'tomorrow'
$ stup add @ tomorrow -n "A new note"

# Explicit with date alias ommiting the `@` option
$ stup add tomorrow -n "A new note"

# Explicit without alias (suppose the date is April 17th, 2020)
$ stup add @ 2020-04-18 -n "A new note"
```

##### Add two notes at once

```bash
$ stup add today -n "Reviewed PR ..." -n "Merged to master..."
```

##### Add to a non-default category

```bash
# Add a note to a category named 'blocking'
$ stup add -c "blocking" -n "Can't continue unless"
```

### Show notes

To view your notes on a given date, use the `show` command.

```bash
$ stup show
```

The full version of the command is:

```bash
$ stup show @ <when> -c|--category "<category-name>"
```

where:

  * `@` or `--at` or `-@`: is the date option
    * `<when>`: specifies which date's notes should be shown. Its value can be:
      * any of the words: `today`, `tomorrow`, `yesterday` in which case you can omit the `@` option
      * a date string in the form: YYYY-MM-DD, example: 2020-04-12
    * **if you omit this option, `stup` by default will show you your yesterday's notes**
  * `<category-name>`: the name of the category whose notes will be shown. **You may omit this option if you want to see notes from all the categories**.

If you don't specify a category and you have more than one, the default behaviour is to show notes only from the categories that have notes the specified day.
If you prefer though to show the "empty" categories as well, you may use the `--include-empty`.

**Notes:**
* the default action of `stup` is to show you your notes so you may write the command without the `show` directive (see the examples).
* if you request to view your notes on a date that you haven't added anything, `stup` will ask if you want to see the notes of the latest date on which something was added before the one you specified.

  For example, if it is **Monday** and you **didn't add any notes during the weekend**, when you type `stup yesterday` you'll be prompted to **see the notes added on Friday**.

#### Examples

##### Show yesterday's notes

All of the following commands are equivalent.

```bash
# Imply "show" as action and "yesterday" alias as date
$ stup

# Imply "yesterday" as date
$ stup show

# Explicit date set to "yesterday" date alias
$ stup yesterday

# Explicit date (given that current date is April 17th, 2020)
$ stup @ 2020-04-16
```

##### Show today's notes

All of the following commands are equivalent.

```bash
# Imply "show" as action
$ stup today

# Show today's notes for the category "meetings"
$ stup today -c "meetings"

# Show today's notes for the category "meetings" by explicitly setting action to "show"
$ stup show today -c "meetings"
```

##### Show notes on a past date

```bash
# Show notes on April's Fool Day
$ stup show @ 2020-04-01
```

##### Show notes of a specific category

```bash
# Show today's notes added in category "pull-requests"
$ stup show today -n "pull-requests"
```

### Edit notes

To manually edit notes added in a specific date use the `edit` command.

```bash
$ stup edit yesterday
```

The full version of the command as below:

```bash
stup edit @|--at|-@ <when> -c|--category "<category-name>"
```

where:
  * `<when>`: specifies in which date the notes should be added. Its value can be:
    * any of the words: `today`, `tomorrow`, `yesterday` in which case you can omit the `@`|`--at`|`-@` option
    * a date string in the form: `YYYY-MM-DD`, for example: 2020-04-12
    * **if you omit this option, `stup` by default will edit the notes in the current date**
  * `-c` or `--category`: is the category option (optional). **If omitted, you will edit the notes of your default category**
    * `<category-name>`: the name of the category in which the notes will be added

**Note:** If there are no notes for a specific date and category, you will be asked if you want to create and edit the file anyway.

#### Examples

##### Editing yesterday's notes

```bash
# Ommiting category option, implying the default one
$ stup edit yesterday

# Editing yesterday's notes for the category with name "blocking"
$ stup edit @ yesterday -c "blocking"
```

##### Editing notes on specific date

```bash
# Ommiting category option, implying the default one
$ stup edit @ 2020-03-24

# Editing notes saved on March 24th, 2020 for the category with name "blocking"
$ stup edit @ 2020-03-24 -c "blocking"
```


### Log notes

To list your notes for a given period, use the `log` command.

```bash
$ stup log previous-week
```

The full version of the command:

```bash
$ stup log --from <from-date> --to <to-date> -c <category-name>

# or using an alias

$ stup log <week|previous-week|month|previous-month|year|previous-year>
```

where:

- `<from-date>`: is a date alias (`today`, `yesterday`, `tomorrow`) or a specific date using the format `YYYY-MM-DD`, for example: 2020-04-18
  - this is optional and if omitted the notes to be displayed won't have be **added after a specific date**
- `<to-date>`: is also a date alias (`today`, `yesterday`, `tomorrow`) or a specific date using the format `YYYY-MM-DD`, for example: 2020-04-18
  - this is also optional and if omitted the notes to be displayed won't have be **added before a specific date**
* `-c` or `--category`: is the category option (optional). **If omitted, you will view the notes of all categories**
  * `<category-name>`: the name of the category whose notes you want to see

In the second version of the command, you can use the temporal aliases that will be translated to proper from/to dates.

#### Examples

##### Log of this week's notes

```bash
$ stup log week
```

##### Log of previous week's notes

```bash
$ stup log previous-week
```

##### Log of notes added in a specific period

```bash
$ stup log --from 2020-01-15 --to 2020-02-01
```

##### Log of notes added in a specific period in the category "blocking"

```bash
$ stup log --from 2020-01-15 --to 2020-02-01 -c blocking
```

### Add a new category

To add a new category to save notes into use the following command.

```bash
$ stup add-category --category-name "<category-name>" --category-description "<category-description>"
```

where:

- `<category-name>`: the name of the category to be created. This is going to be a directory so make sure it's a valid directory name.
- `<category-description>`: the description of this category. Even though this is optionally set, it is highly recommended to be defined. Whenever `stup` shows your notes, the title of each category will default to the category name if the category doesn't have a description.
  ```stup
  # Without a description for category with name mobile
  $ stup yesterday

  Displaying notes for Friday, April 16th 2020.

  >>> mobile

  - A note
  - Another note
  - ...
  ```

  vs

  ```
  # With mobile's category description set to "Mobile related notes"

  $ stup yesterday

  Displaying notes for Friday, April 16th 2020.

  >>> Mobile related notes

  - A note
  - Another note
  - ...

  ```

### Set a category's description

To set a new description or change the existing description of a category use the following command.

```bash
$ stup set-category-description --category-name "<category-name>" --category-description "<category-description>"
```

where:

- `<category-name>`: the name of the category whose description will be set. If you omit this options, you will change the description of your default category.
- `<category-description>`: the description to set

### List your categories

To see all your categories use the `list-categories` command as shown below:

```bash
$ stup list-categories

# or the equivalent

$ stup --list-categories
```

### Change the order of categories

To change the order of your categories (affecting the order with which the notes are shown) use the `order-categories` command as shown below:

```bash
$ stup order-categories

# or the equivalent

$ stup --order-categories
```

This command opens the categories registry file in your editor and you can change the order by moving the category names up and down.

## Future work

New features that are on the top of my list for `stup`:

* Add [bash completion](https://github.com/iridakos/stup/issues/2)
* Ability to [search notes](https://github.com/iridakos/stup/issues/7)
* Ability to [export notes](https://github.com/iridakos/stup/issues/8) to a file

You can find more information about what is planned to be implemented browsing the [GitHub repository's issues labeled as `new feature`](https://github.com/iridakos/stup/issues?q=is%3Aissue+is%3Aopen+label%3A%22new+feature%22)

## Contributing

1. Create an issue describing the purpose of the pull request unless there is one already
2. Fork the repository ( https://github.com/iridakos/stup/fork )
3. Create your feature branch (`git checkout -b my-new-feature`)
4. Commit your changes (`git commit -am 'Add some feature'`)
5. Push to the branch (`git push origin my-new-feature`)
6. Create a new Pull Request

## License

This tool is open source under the [MIT License](https://opensource.org/licenses/MIT) terms.

[[Back To Top]](#stup)

## Contributors ✨

Thanks goes to these wonderful people ([emoji key](https://allcontributors.org/docs/en/emoji-key)):

<!-- ALL-CONTRIBUTORS-LIST:START - Do not remove or modify this section -->
<!-- prettier-ignore-start -->
<!-- markdownlint-disable -->
<table>
  <tr>
    <td align="center"><a href="https://github.com/tiosgz"><img src="https://avatars1.githubusercontent.com/u/53824308?v=4" width="100px;" alt=""/><br /><sub><b>Bohdan Potměkleč</b></sub></a><br /><a href="https://github.com/iridakos/stup/commits?author=tiosgz" title="Code">💻</a></td>
  </tr>
</table>

<!-- markdownlint-enable -->
<!-- prettier-ignore-end -->
<!-- ALL-CONTRIBUTORS-LIST:END -->

This project follows the [all-contributors](https://github.com/all-contributors/all-contributors) specification. Contributions of any kind welcome!
