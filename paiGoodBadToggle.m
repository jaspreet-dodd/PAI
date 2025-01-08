% paiGoodBadToggle

if D(trn).good == 0
    set(h.trialGood, 'ForegroundColor', 'g', 'String', 'Trial GOOD');
elseif D(trn).good == 1
    set(h.trialGood, 'ForegroundColor', 'r', 'String', 'Trial BAD');
end