-- Función para obtener todos los keymaps
local function list_keymaps()
	local keymaps = vim.api.nvim_get_keymap("")
	local result = {}
	for _, map in pairs(keymaps) do
		-- Si el campo 'rhs' es nil, usa 'desc' si está disponible
		local rhs_or_desc = map.rhs or map.desc or "No Command or Description"
		table.insert(result, {
			mode = map.mode,
			lhs = map.lhs,
			rhs = rhs_or_desc,
		})
	end
	return result
end

-- Obtener la ruta de la carpeta actual
local current_path = vim.fn.expand("%:p:h")

-- Nombre del archivo donde se guardará la salida
local output_file = current_path .. "/keymaps_output.txt"

-- Ejecuta la función y guarda el resultado en una tabla
local keymaps = list_keymaps()

-- Abre el archivo para escribir
local file = io.open(output_file, "w")

-- Escribe la tabla de keymaps en el archivo
for _, map in ipairs(keymaps) do
	file:write(string.format("Mode: %s | Key: %s | Command: %s\n", map.mode, map.lhs, map.rhs))
end

-- Cierra el archivo
file:close()

-- Mensaje de confirmación
print("Keymaps guardados en " .. output_file)
