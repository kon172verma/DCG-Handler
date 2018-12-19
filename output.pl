sentence(_4758,_4764):-noun_phrase(_4758,_4794),verb_phrase(_4794,_4764).
noun_phrase(_4866,_4872):-det(_4866,_4902),noun(_4902,_4872).
verb_phrase(_4974,_4980):-verb(_4974,_5010),noun_phrase(_5010,_4980).
det([the|_5088],_5088):-true.
det([a|_5130],_5130):-true.
noun([cat|_5172],_5172):-true.
noun([bat|_5214],_5214):-true.
verb([eats|_5256],_5256):-true.
