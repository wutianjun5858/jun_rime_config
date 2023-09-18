function date_translator(input, seg)
    if (input == "date") then
       --- Candidate(type, start, end, text, comment)
       yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d"), "日期"))
       yield(Candidate("date", seg.start, seg._end, os.date("%Y年%m月%d日"), "日期"))
    end
    if (input == "time") then
       --- Candidate(type, start, end, text, comment)
       yield(Candidate("date", seg.start, seg._end, os.date("%H:%M"), "时间"))
       yield(Candidate("date", seg.start, seg._end, os.date("%H:%M:%S"), "时间"))
    end
    if (input == "datetime") then
       --- Candidate(type, start, end, text, comment)
       yield(Candidate("date", seg.start, seg._end, os.date("%Y-%m-%d %H:%M:%S"), "日期时间"))
    end
	if (input == "week") then
	   local weakTab = {'日', '一', '二', '三', '四', '五', '六'}
       yield(Candidate("week", seg.start, seg._end, "周"..weakTab[tonumber(os.date("%w")+1)], ""))
       yield(Candidate("week", seg.start, seg._end, "星期"..weakTab[tonumber(os.date("%w")+1)], ""))
       yield(Candidate("week", seg.start, seg._end, "礼拜"..weakTab[tonumber(os.date("%w")+1)], ""))
	   yield(Candidate("week", seg.start, seg._end, "week"..math.ceil(os.date("%W")+1), ""))
	end
 end
 
 --- 过滤器：单字在先
 function single_char_first_filter(input)
    local l = {}
    for cand in input:iter() do
       if (utf8.len(cand.text) == 1) then
          yield(cand)
       else
          table.insert(l, cand)
       end
    end
    for i, cand in ipairs(l) do
       yield(cand)
    end
 end

