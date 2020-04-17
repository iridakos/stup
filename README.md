# stup

A shell tool to easily save and view your daily standup notes.

The name derives from the [**St**and**up**](https://en.wikipedia.org/wiki/Stand-up_meeting) meetings.

## Installation

For the moment, the installation is manual until [this issue](https://github.com/iridakos/stup/issues/2) is resolved.

So, you just have to place the executable `stup` script in a directory included in your `$PATH` variable.

## Configuration

Before you start using `stup` you have to configure it with:

```bash
stup --configure
```

Follow the wizard to define:

* to which directory `stup` will be saving your notes
* what is the name of the default repository \*
* what is the editor you want to use to manually edit your notes when using the `edit` command

**\*** You can use `stup` with just a default repository but in case you want to add your notes structured for example per project or per any type of section you want, you have the option to setup multiple repositories (see below).

## Usage

### Adding notes

To add notes use the `add` command as below:

```bash
stup add @|--at|-@ <when> -n|--note "<note text>" -r|--repository "<repository-name>"
```

where:
  * `<when>`: specifies in which date the notes should be added. Its value can be:
    * any of the words: `today`, `tomorrow`, `yesterday` in which case you can ommit the `@`|`--at`|`-@` option
    * a date string in the form: `YYYY-MM-DD`, for example: 2020-04-12
    * **if you ommit this option, `stup` by default will save the notes in the current date**
  * `<note-text>`: the text of the note, for example: "Reviewed PR related to..."
  * `-r` or `--repository`: is the repository option (optional). **If ommited, notes will be saved to your default repository**
    * `<repository-name>`: the name of the repository in which the notes will be added

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
$ stup add @ yesteday -i "A new note"

# Explicit with date alias ommiting the `@` option
$ stup add yesteday -i "A new note"

# Explicit without alias (suppose the date is April 17th, 2020)
$ stup add @ 2020-04-16 -i "A new note"
```

##### Add a note for tomorrow

All of the following commands are equivalent.

```bash
# Explicit with date alias 'tomorrow'
$ stup add @ tomorrow -i "A new note"

# Explicit with date alias ommiting the `@` option
$ stup add tomorrow -i "A new note"

# Explicit without alias (suppose the date is April 17th, 2020)
$ stup add @ 2020-04-18 -i "A new note"
```

##### Add two notes at once

```bash
$ stup add today -n "Reviewed PR ..." -n "Merged to master..."
```

##### Add to a non-default repository

```bash
# Add a note to a repository named 'blocking'
$ stup add -r "blocking" -n "Can't continue unless"
```

### Showing notes

To view your notes use the `show` command as below:

```bash
$ stup add @ <when> -r|--repository "<repository-name>"
```

where:

  * `@` or `--at` or `-@`: is the date option
    * `<when>`: specifies which date's notes should be shown. Its value can be:
      * any of the words: `today`, `tomorrow`, `yesterday` in which case you can ommit the `@` option
      * a date string in the form: YYYY-MM-DD, example: 2020-04-12
    * **if you ommit this option, `stup` by default will show you your yesterday's notes**
  * `<repository-name>`: the name of the repository in which the notes will be added

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
# Imply "show" as action and "yesterday" alias as date
$ stup

# Imply "yesterday" as date
$ stup show

# Explicit date set to "yesterday" date alias
$ stup yesterday

# Explicit date (given that current date is April 17th, 2020)
$ stup @ 2020-04-16
```

##### Show notes on a past date

```bash
# Show notes on April's Fool Day
$ stup show @ 2020-04-01
```

##### Show notes of a specific repository

```bash
# Show today's notes added in repository "pull-requests"
$ stup show today -r "pull-requests"
```

### Editing notes of a specific date

To edit notes added in a specific date use the `edit` command as below:

```bash
stup edit @|--at|-@ <when> -r|--repository "<repository-name>"
```

where:
  * `<when>`: specifies in which date the notes should be added. Its value can be:
    * any of the words: `today`, `tomorrow`, `yesterday` in which case you can ommit the `@`|`--at`|`-@` option
    * a date string in the form: `YYYY-MM-DD`, for example: 2020-04-12
    * **if you ommit this option, `stup` by default will edit the notes in the current date**
  * `<note-text>`: the text of the note, for example: "Reviewed PR related to..."
  * `-r` or `--repository`: is the repository option (optional). **If ommited, you will edit the notes of your default repository**
    * `<repository-name>`: the name of the repository in which the notes will be added

**Note:** If there are no notes for a specific date and repository, you will be asked if you want to create and edit the file anyway.

#### Examples

##### Editing yesterday's notes

```bash
# Ommiting repository option, implying the default one
$ stup edit yesterday

# Editing yesterday's notes for the repository with name "blocking"
$ stup edit @ yesterday -r "blocking"
```

##### Editing notes on specific date

```bash
# Ommiting repository option, implying the default one
$ stup edit @ 2020-03-24

# Editing notes saved on March 24th, 2020 for the repository with name "blocking"
$ stup edit @ 2020-03-24 -r "blocking"
```

### Adding a repository

To add a new repository to save notes into use the following command.

```bash
$ stup add-repository --repository-name "<repository-name>" --repository-description "<repository-description>"
```

where:

- `<repository-name>`: the name of the repository to be created. This is going to be a directory so make sure it's a valid directory name.
- `<repository-description>`: the description of this repository. Even though this is optionally set, it is highly recommended to be defined. Whenever `stup` shows your notes, the title of each repository will default to the repository name if the repository doesn't have a description.
  ```stup
  # Without a description for repository with name mobile
  $ stup yesterday

  Displaying notes for Friday, April 16th 2020.

  >>> mobile

  - A note
  - Another note
  - ...
  ```

  vs

  ```
  # With mobile's repository description set to "Mobile related notes"

  $ stup yesterday

  Displaying notes for Friday, April 16th 2020.

  >>> Mobile related notes

  - A note
  - Another note
  - ...

  ```

### Setting a repository's description

To set a new description or change the existing description of a repository use the following command.

```bash
$ stup set-repository-description --repository-name "<repository-name>" --repository-description "<repository-description>"
```

where:

- `<repository-name>`: the name of the repository whose description will be set. If you ommit this options, you will change the description of your default repository.
- `<repository-description>`: the description to set

### Showing your repositories

To see all your repositories use the `order-repositories` command as show below:

```bash
$ stup show-repositories

# or the equivalent

$ stup --show-repositories
```

### Changing the order of your repositories

To change the order of your repositories (affecting the order with which the notes are shown) use the `order-repositories` command as shown below:

```bash
$ stup order-repositories

# or the equivalent

$ stup --order-repositories
```

This command opens the repositories registry file in your editor and you can change the order by moving the repository names up and down.

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