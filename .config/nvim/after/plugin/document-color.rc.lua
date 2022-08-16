local status, documentColor = pcall(require, 'document-color')
if (not status) then return end

documentColor.setup {
  mode = "background"
}
