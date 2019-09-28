
---To retrieve Fiben Table data stored

SELECT * FROM exav_addon_text WHERE exa_token IN (SELECT token FROM entity_child_base WHERE id IN (SELECT parent_id FROM ecb_av_addon_varchar WHERE ea_code = 'APIT' AND ea_value = 'ITFT')) ORDER BY timestamp_punch DESC LIMIT 500