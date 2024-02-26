local status, skkeletonIndicator = pcall(require, "skkeleton_indicator")
if not status then
	return
end

skkeletonIndicator.setup({
	eijiHlName = "LineNr",
	hiraHlName = "String",
	kataHlName = "Todo",
	hankataHlName = "Special",
	zenkakuHlName = "LineNr",
	alwaysShown = false,
})
