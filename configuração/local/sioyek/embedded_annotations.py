'''
This script was tested with PyMuPDF version 1.17.6. Other versions may require
slight modification of the code.

This script can be used to embed annotations as you create them, so they are
viewable in other PDF viewers.
This is basically a script that can either add a bookmark or a highlight to a
page based on the command line arguments.
Here is the `prefs_user.config` that I used:

	execute_command_b python
		path/to/embedded_annotations.py bookmark "%1" %{mouse_pos_document} "%5"
	execute_command_h python
		path/to/embedded_annotations.py highlight "%1" "%4" "%3"

And here is a `keys_user.config` file that can be used:

	execute_command_b b
	execute_command_h;add_highlight h

which basically adds both sioyek and embedded highlights and bookmarks
(if `ADD_BOOKMARKS_TO_SIOYEK` is True). Alternatively, you can use
a different keybinding for embedded annotations so you have control over what
happens. Now you can use alt+b or alt+h to bookmark/highlight.

	execute_command_b <A-b>
	execute_command_h <A-h>
'''

import sys
import fitz
import subprocess

# if set to true, we re-add the bookmarks into sioyek,
# so we have both types of bookmarks
ADD_BOOKMARKS_TO_SIOYEK = True
PATH_TO_SIOYEK = r'sioyek'


def add_highlight(
	doc_path: str,
	page_number: int,
	text: str
):
	doc = fitz.open(doc_path)
	page = doc.load_page(page_number)

	quads = page.search_for(text, flags=fitz.TEXT_PRESERVE_WHITESPACE)

	page.add_highlight_annot(quads)
	doc.saveIncr()
	doc.close()


def add_bookmark(
	doc_path: str,
	page_number: int,
	location: tuple[float, float],
	text: str
):
	doc = fitz.open(doc_path)
	page = doc.load_page(page_number)
	page.add_text_annot(location, text)
	doc.saveIncr()
	doc.close()
	if ADD_BOOKMARKS_TO_SIOYEK:
		subprocess.run([
			PATH_TO_SIOYEK,
			'--execute-command',
			'add_bookmark',
			'--execute-command-data',
			text
		])
		subprocess.run([
			PATH_TO_SIOYEK,
			'--execute-command',
			'reload'
		])


if __name__ == '__main__':

	path = sys.argv[2]
	text = sys.argv[4]

	# Remove double quotes.
	path = path[1:-1]
	text = text[1:-1]

	if sys.argv[1] == 'bookmark':
		# They came as a single argument "D F.F F.F",
		# where D is digit and F is float.
		args = sys.argv[3].split(' ')

		page = int(args[0])
		location = (float(args[1]), float(args[2]))

		add_bookmark(path, page, location, text)

	elif sys.argv[1] == 'highlight':

		page_h = sys.argv[3]
		# Remove double quotes.
		page_h = page_h[1:-1]

		add_highlight(path, int(page_h), text)
