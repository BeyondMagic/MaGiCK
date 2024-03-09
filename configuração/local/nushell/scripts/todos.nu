# João Farias © BeyondMagic <beyondmagic@mail.ru> 2024

const default_database = `~/armazenamento/afazeres/geral.json`

# Add todo to database.
export def add [
	task: string # Activity to do.
	due?: datetime # Data the entrega.
	--database: string = $default_database # The database of the todos.
]: nothing -> nothing {
	let data = open $database

	{
		task: $task
		done: false
		due_at: $due
		added_at: (date now)
	} ++ $data
	| save --force $database
}

# List all todos.
export def main [
	database: string = $default_database # The database of the todos.
]: nothing -> table<any> {
	open $database
	| update added_at {
		into datetime
	}
	| update due_at {
		if ($in | is-not-empty) {
			into datetime
		}
	}
	| sort-by due_at
	| reverse
}
