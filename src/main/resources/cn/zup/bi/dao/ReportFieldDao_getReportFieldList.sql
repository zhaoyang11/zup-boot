SELECT brf.REPORT_FIELD_ID, brf.REPORT_ID, brf.FIELD_LOCATION, brf.DIM_ORDER, btf.FIELD_TITLE  FIELD_NAME, brf.FIELD_ID, brf.DISPLAY
FROM bi_report_field brf 
JOIN bi_topic_field btf ON brf.FIELD_ID = btf.FIELD_ID
WHERE 1=1

<#if reportField.report_Id?exists>
	AND brf.REPORT_ID = ${ reportField.report_Id}
</#if>

<#if reportField.field_Location?exists>
	AND brf.FIELD_LOCATION = ${ reportField.field_Location}
</#if>