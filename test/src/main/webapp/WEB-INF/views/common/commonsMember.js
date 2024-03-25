function generatePositionSelect(memberPos) {
    var positions = {
				    'D201': '회장',
				    'D202': '부회장',
				    'D203': '사장',
				    'D204': '부사장',
				    'D205': '전무',
				    'D206': '상무',
				    'D207': '본부장',
				    'D208': '실장',
				    'D209': '팀장',
				    'D210': '부장',
				    'D211': '차장',
				    'D212': '과장',
				    'D213': '대리',
				    'D214': '주임',
				    'D215': '사원',
				    'D216': '인턴'
			};

    var select_memberPos = "<select id='memberPos'><option value='' " + (memberPos == '(미정)' ? 'selected' : '') + ">선택</option>";

    for (var key in positions) {
        select_memberPos += "<option value='" + key + "'" + (memberPos == positions[key] ? " selected" : '') + ">" + positions[key] + "</option>";
    }

    select_memberPos += "</select>";
    return select_memberPos;
};


