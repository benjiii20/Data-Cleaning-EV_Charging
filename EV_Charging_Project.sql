select*
from charging_data;

-- Data Cleaning 
-- Steps :
-- 1.Remove Columns
-- 2.Remove Duplicates
-- 3.Standardize the data

-- Create a backup database

create table charging_data2
like charging_data;

select*
from charging_data2
;

insert charging_data2
select*
from charging_data
;

select*
from charging_data2;

-- Remove Columns

alter table charging_data2
drop column steckertypen1,
drop column steckertypen2,
drop column steckertypen3,
drop column steckertypen4,
drop column p1_kw,
drop column p2_kw,
drop column p3_kw,
drop column p4_kw,
drop column kreis_kreisfreie_stadt,
drop column ort,
drop column postleitzahl,
drop column strasse,
drop column hausnummer,
drop column adresszusatz,
drop column breitengrad,
drop column laengengrad
;

select*
from charging_data2;

-- Identidying Duplicates

with duplicate_cte as
(
select*,
row_number() over(
partition by betreiber, art_der_ladeeinrichung, anzahl_ladepunkte, anschlussleistung, inbetriebnahmedatum) as row_num
from charging_data2
)
select*
from duplicate_cte
where row_num>1
;

-- Delete the duplicates


CREATE TABLE `charging_data3` (
  `betreiber` text,
  `art_der_ladeeinrichung` text,
  `anzahl_ladepunkte` int DEFAULT NULL,
  `anschlussleistung` double DEFAULT NULL,
  `inbetriebnahmedatum` text,
  `row_num`int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select*
from charging_data3
where row_num>1
;

insert into charging_data3
select*,
row_number() over(
partition by betreiber, art_der_ladeeinrichung, anzahl_ladepunkte, anschlussleistung, inbetriebnahmedatum) as row_num
from charging_data2;

delete
from charging_data3
where row_num>1
;

select*
from charging_data3;

-- Remove row_num column

alter table charging_data3
drop column row_num
;
select*
from charging_data3;

-- Standardizing data

select betreiber, trim(betreiber)
from charging_data3
;

update charging_data3
set betreiber = trim(betreiber)
;

select distinct betreiber
from charging_data3
order by 1;

select betreiber
from charging_data3
;

update charging_data3
set betreiber = 'Öffentliche Ladestation Pension Mia Bella'
where betreiber like 'Ã–ffentliche Ladestation Pension Mia Bella';

update charging_data3
set betreiber = 'ABB Autohaus Görlitz GmbH'
where betreiber like 'ABB Autohaus GÃ¶rlitz GmbH';


update charging_data3
set betreiber = case
when betreiber = 'Adrian GlÃ¶ckner Automobile GmbH' then 'Adrian Glöckner Automobile GmbH'
when betreiber = 'AH RÃ¶ll GmbH' then 'AH Röll GmbH'
when betreiber = 'AH SchlÃ¶gl GmbH & CoKG' then 'AH Schlögl GmbH & Co. KG'
when betreiber = 'AHAG DÃ¼lmen GmbH' then 'AHAG Dülmen GmbH'
when betreiber = 'Albatros Multi Tenant S.Ã¡ r.l c/o NAS Real SÃ¼d West GmbH' then 'Albatros Multi Tenant S.à r.l c/o NAS Real Süd West GmbH'
when betreiber = 'AHAG DÃ¼lmen GmbH' then 'AHAG Dülmen GmbH'
when betreiber = 'ALDI SÃœD' then 'ALDI SÜD'
when betreiber = 'AllgÃ¤uer Ãœberlandwerk GmbH' then 'Allgäuer Überlandwerk GmbH'
when betreiber = 'AllgÃ¤uer Integrationsbetrieb CAP Markt gemeinnÃ¼tzige GmbH' then 'Allgäuer Integrationsbetrieb CAP Markt gemeinnützige GmbH'
when betreiber = 'AllgÃ¤uer Kraftwerke GmbH' then 'Allgäuer Kraftwerke GmbH'
when betreiber = 'Am SÃ¼dharz GmbH' then 'Am Südharz GmbH'
when betreiber = 'AMB Automobile Borna GmbH, NL BÃ¶hlen' then 'AMB Automobile Borna GmbH, NL Böhlen'
when betreiber = 'Ambulanter Pflegedienst Angelika MÃ¼ller e.K.' then 'Ambulanter Pflegedienst Angelika Müller e.K.'
when betreiber = 'Amt fÃ¼r ErnÃ¤hrung, Landwirtschaft und Forsten Roth' then 'Amt für Ernährung, Landwirtschaft und Forsten Roth'
when betreiber = 'Amt HÃ¼ttener Berge, Gemeinde Ascheffel' then 'Amt Hüttener Berge, Gemeinde Ascheffel'
when betreiber = 'AndrÃ¨ Lackner Einzelunternehmen' then 'André Lackner Einzelunternehmen'
when betreiber = 'Andreas PfÃ¼ller - Autohaus Stollberg e.K' then 'Andreas Pfüller - Autohaus Stollberg e.K.'
when betreiber = 'Ãœberlandwerk Erding GmbH & Co. KG' then 'Überlandwerk Erding GmbH & Co. KG'
when betreiber = 'Ãœberlandwerk Leinetal GmbH' then 'Überlandwerk Leinetal GmbH'
when betreiber = 'Ãœberlandwerk SchÃ¤ftersheim GmbH & Co. KG' then 'Überlandwerk Schäftersheim GmbH & Co. KG'
when betreiber = 'Ãœberlandzentrale WÃ¶rth/Isar Altheim Netz AG' then 'Überlandzentrale Wörth/Isar Altheim Netz AG'
when betreiber = 'ÃœZ Mainfranken eG' then 'ÜZ Mainfranken eG'
when betreiber = 'Apartment H2 DÃ¼sseldorf' then 'Apartment H2 Düsseldorf'
when betreiber = 'ArchitekturbÃ¼ro Seidel, Freiberufler' then 'Architekturbüro Seidel, Freiberufler'
when betreiber = 'arcona Hotel ThÃ¼ringer Hof GmbH' then 'arcona Hotel Thüringer Hof GmbH'
when betreiber = 'Audi Zentrum Passau Erich RÃ¶hr GmbH & Co. KG' then 'Audi Zentrum Passau Erich Röhr GmbH & Co. KG'
when betreiber = 'Auto BÃ¶deker GmbH' then 'Auto Bödeker GmbH'
when betreiber = 'Auto Center AndrÃ© MÃ¼hlenbruch GmbH' then 'Auto Center André Mühlenbruch GmbH'
when betreiber = 'Auto Center NordÂ GmbH' then 'Auto Center Nord GmbH'
when betreiber = 'Auto KÃ¶hler GmbH & Co. KG' then 'Auto Köhler GmbH & Co. KG'
when betreiber = 'Auto KÃ¶nig GmbH & Co.KG' then 'Auto König GmbH & Co. KG'
when betreiber = 'Auto KÃ¶nig GmbH&Co.KG' then 'Auto König GmbH & Co. KG'
when betreiber = 'Auto KÃ¼hn GmbH' then 'Auto Kühn GmbH'
when betreiber = 'Auto RÃ¶hr Grafenau Ndl. d. Erich RÃ¶hr GmbH & Co. KG' then 'Auto Röhr Grafenau Ndl. d. Erich Röhr GmbH & Co. KG'
when betreiber = 'Auto WÃ¼st GmbH' then 'Auto Wüst GmbH'
when betreiber = 'Auto-Ã–stringer GmbH' then 'Auto-Östringer GmbH'
when betreiber = 'Auto-HÃ¤user GmbH & Co. KG' then 'Auto-Häuser GmbH & Co. KG'
when betreiber = 'Auto-HÃ¼bner GmbH & Co. KG' then 'Auto-Hübner GmbH & Co. KG'
when betreiber = 'Auto-Technik DÃ¤hne GmbH' then 'Auto-Technik Dähne GmbH'
when betreiber = 'Auto-TrÃ¶ndle GmbH & Co. KG' then 'Auto-Tröndle GmbH & Co. KG'
when betreiber = 'Auto-WÃ¼nsch KG' then 'Auto-Wunsch KG'
when betreiber = 'Autoarena MÃ¼nchen GmbH' then 'Autoarena München GmbH'
when betreiber = 'Autodienst JahnsmÃ¼ller GmbH' then 'Autodienst Jahnsmüller GmbH'
when betreiber = 'AutoForum MÃ¼nchberg GmbH' then 'AutoForum Münchberg GmbH'
when betreiber = 'Autohaus AllgÃ¤u GmbH & Co. KG' then 'Autohaus Allgäu GmbH & Co. KG'
when betreiber = 'Autohaus am BrÃ¼ckentor GmbH & Co. KG' then 'Autohaus am Brückentor GmbH & Co. KG'
when betreiber = 'Autohaus BÃ¶hme GmbH' then 'Autohaus Böhme GmbH'
when betreiber = 'Autohaus BÃ¶ttche GmbH' then 'Autohaus Böttche GmbH'
when betreiber = 'Autohaus BÃ¤umer GmbH' then 'Autohaus Bäumer GmbH'
when betreiber = 'Autohaus BÃ¼tje GmbH' then 'Autohaus Bütje GmbH'
when betreiber = 'Autohaus BaumgÃ¤rtel GmbH' then 'Autohaus Baumgärtel GmbH'
when betreiber = 'Autohaus BeckhÃ¤user' then 'Autohaus Beckhäuser'
when betreiber = 'Autohaus BrÃ¶mmler GmbH' then 'Autohaus Brömmler GmbH'
when betreiber = 'Autohaus DÃ¶beln GmbH' then 'Autohaus Döbeln GmbH'
when betreiber = 'Autohaus DÃ¼rkop GmbH' then 'Autohaus Dürkop GmbH'
when betreiber = 'Autohaus Erlenhoff GmbH vorm. G.LÃ¶w' then 'Autohaus Erlenhoff GmbH vorm. G.Löw'
when betreiber = 'Autohaus Ernst MÃ¼ller GmbH & Co. KG' then 'Autohaus Ernst Müller GmbH & Co. KG'
when betreiber = 'Autohaus FÃ¤rber GmbH' then 'Autohaus Färber GmbH'
when betreiber = 'Autohaus FÃ¼llgraf & Partner Kyritz GmbH' then 'Autohaus Füllgraf & Partner Kyritz GmbH'
when betreiber = 'Autohaus FrÃ¼chtl GmbH' then 'Autohaus Früchtl GmbH'
when betreiber = 'Autohaus GÃ¶thling GmbH' then 'Autohaus Göthling GmbH'
when betreiber = 'Autohaus GÃ¶tz LadesÃ¤ule' then 'Autohaus Götz Ladesäule'
when betreiber = 'Autohaus GrÃ¶pper GmbH' then 'Autohaus Gröpper GmbH'
when betreiber = 'Autohaus GrÃ¼nhage' then 'Autohaus Grünhage'
when betreiber = 'Autohaus GrÃ¼nhagen GmbH & Co KG' then 'Autohaus Grünhagen GmbH & Co KG'
when betreiber = 'Autohaus GrÃ¼tzner GmbH' then 'Autohaus Grünhage'
when betreiber = 'Autohaus Gretenkort GmbH ? Co. KG' then 'Autohaus Gretenkort GmbH & Co. KG'
when betreiber = 'Autohaus Gurrath Gmbh $ Co KG' then 'Autohaus Gurrath GmbH & Co. KG'
when betreiber = 'Autohaus HÃ¶hentinger GmbH' then 'Autohaus Höhentinger GmbH'
when betreiber = 'Autohaus HÃ¶lzer GmbH' then 'Autohaus Hölzer GmbH'
when betreiber = 'Autohaus HÃ¶rig GmbH' then 'Autohaus Hörig GmbH'
when betreiber = 'Autohaus HÃ¼bener GmbH' then 'Autohaus Hübener GmbH'
when betreiber = 'Autohaus Heemann eK Inh. JÃ¼rgen Heemann' then 'Autohaus Heemann eK Inh. Jürgen Heemann'
when betreiber = 'Autohaus KÃ¶pf GmbH' then 'Autohaus Köpf GmbH'
when betreiber = 'Autohaus KÃ¼hne GmbH' then 'Autohaus Kühne GmbH'
when betreiber = 'Autohaus KÃ¼hnert GmbH & Co. KG' then 'Autohaus Kühnert GmbH & Co. KG'
when betreiber = 'Autohaus KÃ¼hne GmbH' then 'Autohaus Kühne GmbH'
when betreiber = 'Autohaus Klaus HÃ¶rsting ek' then 'Autohaus Klaus Hörsting eK'
when betreiber = 'Autohaus KnauÃŸ' then 'Autohaus Knauß'
when betreiber = 'Autohaus KrÃ¶ger' then 'Autohaus Kröger'
when betreiber = 'Autohaus KrÃ¶ger & Partner GmbH' then 'Autohaus Kröger & Partner GmbH'
when betreiber = 'Autohaus LÃ¤mmermann GmbH' then 'Autohaus Lämmermann GmbH'
when betreiber = 'Autohaus LÃ¼hrs GmbH' then 'Autohaus Lührs GmbH'
when betreiber = 'Autohaus MÃ¶ÃŸner GmbH' then 'Autohaus Mößner GmbH'
when betreiber = 'Autohaus MÃ¤rkisches Tor GmbH' then 'Autohaus Märkisches Tor GmbH'
when betreiber = 'Autohaus MÃ¼ller Eilenburg GmbH' then 'Autohaus Müller Eilenburg GmbH'
when betreiber = 'Autohaus MÃ¼ller GmbH' then 'Autohaus Müller GmbH'
when betreiber = 'Autohaus MÃ¼ller GmbH & Co. KG' then 'Autohaus Müller GmbH'
when betreiber = 'Autohaus MÃ¼ller Leipzig' then 'Autohaus Müller Leipzig'
when betreiber = 'Autohaus MÃ¼ller Reudnitz GmbH' then 'Autohaus Müller Reudnitz GmbH'
when betreiber = 'Autohaus MÃ¼ller Wurzen GmbH' then 'Autohaus Müller Wurzen GmbH'
when betreiber = 'Autohaus MarkÃ¶tter GÃ¼tersloh' then 'Autohaus Märkötter Gütersloh'
when betreiber = 'Autohaus NÃ¶lscher GmbH' then 'Autohaus Nölscher GmbH'
when betreiber = 'Autohaus PrÃ¼ller e.K.' then 'Autohaus Prüller e.K.'
when betreiber = 'Autohaus RÃ¤thel GmbH' then 'Autohaus Räthel GmbH'
when betreiber = 'Autohaus Raith, Riebold-RÃ¶sner-Raith GmbH' then 'Autohaus Raith, Riebold-Rösner-Raith GmbH'
when betreiber = 'Autohaus Reiner FÃ¼tz GmbH & Co. KG' then 'Autohaus Reiner Fütz GmbH & Co. KG'
when betreiber = 'Autohaus SÃ¼dring GmbH' then 'Autohaus Südring GmbH'
when betreiber = 'Autohaus SÃ¼dring GmbH & Co KG' then 'Autohaus Südring GmbH & Co. KG'
when betreiber = 'Autohaus SchÃ¼ler & Co GmbH' then 'Autohaus Schüler & Co. GmbH'
when betreiber = 'Autohaus Schlutter GmbH Â  Hyundai VertragshÃ¤ndler' then 'Autohaus Schlutter GmbH'
when betreiber = 'Autohaus Schmidt & SÃ¶hne' then 'Autohaus Schmidt & Söhne'
when betreiber = 'Autohaus Schmidt & SÃ¶hne Aschersleben GmbH & Co. KG' then 'Autohaus Schmidt & Söhne Aschersleben GmbH & Co. KG'
when betreiber = 'Autohaus Schmidt & SÃ¶hne GmbH' then 'Autohaus Schmidt & Söhne GmbH'
when betreiber = 'Autohaus Schmidt & SÃ¶hne GmbH & Co. KG' then 'Autohaus Schmidt & Söhne GmbH & Co. KG'
when betreiber = 'Autohaus SchrÃ¶er GmbH' then 'Autohaus Schröer GmbH'
when betreiber = 'Autohaus SpÃ¶rlein' then 'Autohaus Spörlein'
when betreiber = 'Autohaus SteinbÃ¶hmer' then 'Autohaus Spörlein'
when betreiber = 'Autohaus SteinbÃ¶hmer GmbH & Co. KG' then 'Autohaus Steinböhmer GmbH & Co. KG'
when betreiber = 'Autohaus SteinbÃ¶hmer GmbH&Co.KG' then 'Autohaus Steinböhmer GmbH & Co. KG'
when betreiber = 'Autohaus StrÃ¶bele GmbH' then 'Autohaus Ströbele GmbH'
when betreiber = 'Autohaus StrauÃŸ GmbH' then 'Autohaus Strauss GmbH'
when betreiber = 'Autohaus TÃ¶nnemann GmbH & Co. KG' then 'Autohaus Tönnemann GmbH & Co. KG'
when betreiber = 'Autohaus VÃ¶ge e.K. Inh. E. Strobel' then 'Autohaus Vöge e.K. Inh. E. Strobel'
when betreiber = 'Autohaus WÃ¶ll e.K.' then 'Autohaus Wöll e.K.'
when betreiber = 'Autohaus WaldmÃ¼ller GmbH' then 'Autohaus Waldmüller GmbH'
when betreiber = 'Autohaus Walkenhorst IbbenbÃ¼hren GmbH' then 'Autohaus Walkenhorst Ibbenbüren GmbH'
when betreiber = 'Autohaus WeingÃ¤rtner Miesbach GmbH & Co.KG' then 'Autohaus Weingärtner Miesbach GmbH & Co. KG'
when betreiber = 'Autohaus Wilfried KÃ¼hnicke e.K.' then 'Autohaus Wilfried Kühnicke e.K.'
when betreiber = 'Autohaus Witting & SÃ¶hne GmbH & Co. KG' then 'Autohaus Witting & Söhne GmbH & Co. KG'
when betreiber = 'Automobile KÃ¶pper GmbH' then 'Automobile Köpper GmbH'
when betreiber = 'Automobilzentrum FÃ¼rstenwalde Nord GmbH' then 'Automobilzentrum Fürstenwalde Nord GmbH'
when betreiber = 'Autoreparatur SchÃ¶ne' then 'Autoreparatur Schöne'
when betreiber = 'AVP Sportwagen GmbH AlÃ¶tting' then 'AVP Sportwagen GmbH Alötting'
when betreiber = 'BÃ„RMAG Berlin Makler UG' then 'BÄRMAG Berlin Makler UG'
when betreiber = 'BÃ¶hm Elektrobau, Inh. Martin BÃ¶hm' then 'Böhm Elektrobau, Inh. Martin Böhm'
when betreiber = 'BÃ¶wing Energietechnik GmbH & Co. KG' then 'Böwing Energietechnik GmbH & Co. KG'
when betreiber = 'BÃ¤ckerei LÃ¼ttel' then 'Bäckerei Lüttel'
when betreiber = 'BÃ¤ckerei Vatter' then 'Bäckerei Vatter'
when betreiber = 'BÃ¼chelbergerei Chaletdorf' then 'Büchelbergerei Chaletdorf'
when betreiber = 'BÃ¼ckeberg-Klinik GmbH & Co. KG' then 'Bückeberg-Klinik GmbH & Co. KG'
when betreiber = 'BÃ¼rger Energie Drebach eG' then 'Bürger Energie Drebach eG'
when betreiber = 'BÃ¼rger Energie St. Peter eG' then 'Bürger Energie St. Peter eG'
when betreiber = 'BÃ¼rger-Energie Genossenschaft Freisinger Land eG' then 'Bürger-Energie Genossenschaft Freisinger Land eG'
when betreiber = 'BÃ¼rgerEnergie Niederbayern eG' then 'BürgerEnergie Niederbayern eG'
when betreiber = 'BÃ¼rgerEnergie Rhein-Sieg eG' then 'BürgerEnergie Rhein-Sieg eG'
when betreiber = 'BÃ¼rgerEnergieGenossenschaft Kraichgau eG' then 'BürgerEnergieGenossenschaft Kraichgau eG'
when betreiber = 'BÃ¼rgerEnergieGenossenschaft Sottrum eG' then 'BürgerEnergieGenossenschaft Sottrum eG'
when betreiber = 'BÃ¼rgerEnergieRheinMain eG' then 'BürgerEnergieRheinMain eG'
when betreiber = 'BÃ¼ttenpapierfabrik Gmund GmbH und Co. KG' then 'Büttenpapierfabrik Gmund GmbH und Co. KG'
when betreiber = 'Bau und Heimwerkermarkt MÃ¼llenhoff GmbH' then 'Bau und Heimwerkermarkt Müllenhoff GmbH'
when betreiber = 'Belia Seniorenresidenzen GmbH BetriebsstÃ¤tte Holthausen' then 'Belia Seniorenresidenzen GmbH Betriebsstätte Holthausen'
when betreiber = 'Bernhard HÃ¼bner e.U.' then 'Bernhard Hübner e.U.'
when betreiber = 'Bertrandt Ing.-BÃ¼ro GmbH Tappenbeck' then 'Bertrandt Ing.-Büro GmbH Tappenbeck'
when betreiber = 'Berufsbildungszentrum am Nord-Ostsee- Kanal AÃ¶R' then 'Berufsbildungszentrum am Nord-Ostsee-Kanal AöR'
when betreiber = 'Best Western Plus Hotel BÃ¶ttcherhof' then 'Best Western Plus Hotel Böttcherhof'
when betreiber = 'Best Western Plus Hotel FÃ¼ssen' then 'Best Western Plus Hotel Füssen'
when betreiber = 'Bezirkssparkasse Reichenau Anstalt des Ã¶ffentlichen Rechts' then 'Bezirkssparkasse Reichenau Anstalt des öffentlichen Rechts'
when betreiber = 'bioladen*Weiling' then 'Bioladen Weiling'
when betreiber = 'BMW AG Niederlassung MÃ¼nchen' then 'BMW AG Niederlassung München'
when betreiber = 'BMW Autohaus MÃ¤rtin GmbH' then 'BMW Autohaus Märtin GmbH'
when betreiber = 'BORMANN EDV+ZubehÃ¶r' then 'Bormann EDV+Zubehör'
when betreiber = 'BrÃ¤mswig Energie' then 'Brämswig Energie'
when betreiber = 'BrÃ¼der Ley GmbH' then 'Brüder Ley GmbH'
when betreiber = 'BRK Kreisverband Kronach KdÃ¶R' then 'BRK Kreisverband Kronach KdöR'
when betreiber = 'BSH HausgerÃ¤te GmbH' then 'BSH Hausgeräte GmbH'
when betreiber = 'BTB Blockheizkraftwerks- TrÃ¤ger- und Betreibergesellschaft mbH Berlin' then 'BTB Blockheizkraftwerks-Träger- und Betreibergesellschaft mbH Berlin'
when betreiber = 'Buchwinkler GmbH & Co. KG Volkswagen HÃ¤ndler' then 'Buchwinkler GmbH & Co. KG'
when betreiber = 'Burgunderhof digestifâ€™s GmbH' then "Burgunderhof Digestif's GmbH"
when betreiber = 'Business Park SÃ¼dbaar GmbH' then 'Business Park Südbaar GmbH'
when betreiber = 'Camping HarfenmÃ¼hle' then 'Camping Harfenmühle'
when betreiber = 'Charming Appartements Hans-JÃ¼rgen Robert Straub' then 'Charming Appartements Hans-Jürgen Robert Straub'
when betreiber = 'Christian LÃ¼hmann GmbH' then 'Christian Lühmann GmbH'
when betreiber = 'computer weishÃ¤upl' then 'Computer Weishäupl'
when betreiber = 'Deutsche FunkturmÂ GmbH' then 'Deutsche Funkturm GmbH'
when betreiber = 'Deutsche PrimÃ¤renergie GmbH' then 'Deutsche Primärenergie GmbH'
when betreiber = 'Deutsches Brennstoffinstitut VermÃ¶gensverwaltungs-GmbH' then 'Deutsches Brennstoffinstitut Vermögensverwaltungs-GmbH'
when betreiber = 'Dipl. Ing. H. RÃ¶der GmbH & Co. KG' then 'Dipl. Ing. H. Röder GmbH & Co. KG'
when betreiber = 'DIT GÃ¶ttingen GmbH' then 'DIT Göttingen GmbH'
when betreiber = 'DKB Stiftung Liebenberg GemeinnÃ¼tzige GmbH' then 'DKB Stiftung Liebenberg Gemeinnützige GmbH'
when betreiber = 'dm-VermÃ¶gensverwaltungsgesellschaft mbH' then 'dm-Vermögensverwaltungsgesellschaft mbH'
when betreiber = 'DomÃ¤ne Schaumburg' then 'Domäne Schaumburg'
when betreiber = 'Dr. Bernhard GÃ¶ttler' then 'Dr. Bernhard Göttler'
when betreiber = 'Dr. Bodo MÃ¼ller Gewerbe' then 'Dr. Bodo Müller Gewerbe'
when betreiber = 'DSD â€“ Duales System Services GmbH' then 'DSD – Duales System Services GmbH'
when betreiber = 'E-Charge Geierlay (Freiberufler, FÃ¤rber Ing.-BÃ¼ro)' then 'E-Charge Geierlay (Freiberufler, Färber Ing.-Büro)'
when betreiber = 'E-Tankstelle BaumhÃ¶gger' then 'E-Tankstelle Baumhögger'
when betreiber = 'e.novum LÃ¼neburg gGmbH' then 'e.novum Lüneburg gGmbH'
when betreiber = 'E.RÃ¶hr' then 'E. Röhr'
when betreiber = 'Ebbinghaus GrundstÃ¼cksverwaltungs GmbH & Co. KG' then 'Ebbinghaus Grundstücksverwaltungs GmbH & Co. KG'
when betreiber = 'EDEKA Dirk MÃ¶ller e. K.' then 'Ebbinghaus Grundstücksverwaltungs GmbH & Co. KG'
when betreiber = 'EDEKA KÃ¶nig' then 'EDEKA König'
when betreiber = 'EDEKA KÃ¶rner' then 'EDEKA Körner'
when betreiber = 'EDEKA Markt Kai GÃ¶bel' then 'EDEKA Markt Kai Göbel'
when betreiber = 'EFA Tankstellenbetriebe und MineralÃ¶lhandel GmbH' then 'EFA Tankstellenbetriebe und Mineralölhandel GmbH'
when betreiber = 'EG ElektromobilitÃ¤t GmbH & Co KG' then 'EG Elektromobilität GmbH & Co. KG'
when betreiber = 'EJW Tagungszentrum BernhÃ¤user Forst, KÃ¶rperschaft des Ã¶ffentlichen Rechts' then 'EJW Tagungszentrum Bernhäuser Forst, Körperschaft des öffentlichen Rechts'
when betreiber = 'Electric ELB GebÃ¤udetechnik GmbH' then 'Electric ELB Gebäudetechnik GmbH'
when betreiber = 'ElektrizitÃ¤ts-Werk Ottersberg' then 'Elektrizitäts-Werk Ottersberg'
when betreiber = 'ElektrizitÃ¤tsgenossenschaft Rettenberg e.G.' then 'Elektrizitätsgenossenschaft Rettenberg e.G.'
when betreiber = 'ElektrizitÃ¤tsgenossenschaft Unterneukirchen eG' then 'Elektrizitätsgenossenschaft Unterneukirchen eG'
when betreiber = 'ElektrizitÃ¤tsgenossenschaft Wolkersdorf und Umgebung eG' then 'Elektrizitätsgenossenschaft Wolkersdorf und Umgebung eG'
when betreiber = 'ElektrizitÃ¤tsversorgung Werther GmbH' then 'Elektrizitätsversorgung Werther GmbH'
when betreiber = 'ElektrizitÃ¤tsversorgungsunternehmen (EVU) der Gemeinde Gochsheim' then 'Elektrizitätsversorgungsunternehmen (EVU) der Gemeinde Gochsheim'
when betreiber = 'ElektrizitÃ¤tswerk Goldbach-HÃ¶sbach GmbH & Co. KG' then 'Elektrizitätswerk Goldbach-Hösbach GmbH & Co. KG'
when betreiber = 'ElektrizitÃ¤tswerk Hindelang eG' then 'Elektrizitätswerk Hindelang eG'
when betreiber = 'ElektrizitÃ¤tswerk Karl Stengle GmbH & Co. KG' then 'Elektrizitätswerk Karl Stengle GmbH & Co. KG'
when betreiber = 'ElektrizitÃ¤tswerk Mainbernheim GmbH' then 'Elektrizitätswerk Mainbernheim Gmbh'
when betreiber = 'ElektrizitÃ¤tswerk Tegernsee' then 'Elektrizitätswerk Tegernsee'
when betreiber = 'ElektrizitÃ¤tswerk WennenmÃ¼hle SchÃ¶rger KG' then 'Elektrizitätswerk Wennenmühle Schörger KG'
when betreiber = 'Elektro BrÃ¼nninger GmbH' then 'Elektro Brünninger GmbH'
when betreiber = 'Elektro KeÃŸler GmbH' then 'Elektro Keßler GmbH'
when betreiber = 'Elektro MÃ¼hlbauer GmbH' then 'Elektro Mühlbauer GmbH'
when betreiber = 'Elektro-MÃ¼ller' then 'Elektro-Müller'
when betreiber = 'Elektrotechnik SpÃ¤th' then 'Elektrotechnik Späth'
when betreiber = 'Elektrotechnik Waldemar MÃ¼ller GmbH & Co. KG' then 'Elektrotechnik Waldemar Müller GmbH & Co. KG'
when betreiber = 'EMB Energieversorgung Miltenberg - BÃ¼rgstadt GmbH & Co. KG' then 'EMB Energieversorgung Miltenberg - Bürgstadt GmbH & Co. KG'
when betreiber = 'EMERGY FÃ¼hrungs- und Servicegesellschaft mbH' then 'EMERGY Führungs- und Servicegesellschaft mbH'
when betreiber = 'EMI ElektroMobilitÃ¤tsInfrastruktur GmbH' then 'EMI ElektroMobilitätsInfrastruktur GmbH'
when betreiber = 'Emil Frey KÃ¼stengarage GmbH' then 'Emil Frey Küstengarage GmbH'
when betreiber = 'Energie H+ GmbH ? Co. KG' then 'Energie H+ GmbH & Co. KG'
when betreiber = 'Energie SÃ¼dbayern GmbH' then 'Energie Südbayern GmbH'
end
where betreiber in(
'Adrian GlÃ¶ckner Automobile GmbH',
'AH RÃ¶ll GmbH',
'AH SchlÃ¶gl GmbH & CoKG',
'AHAG DÃ¼lmen GmbH',
'Albatros Multi Tenant S.Ã¡ r.l c/o NAS Real SÃ¼d West GmbH',
'AHAG DÃ¼lmen GmbH',
'ALDI SÃœD',
'AllgÃ¤uer Ãœberlandwerk GmbH',
'AllgÃ¤uer Integrationsbetrieb CAP Markt gemeinnÃ¼tzige GmbH',
'AllgÃ¤uer Kraftwerke GmbH',
'AllgÃ¤uer Integrationsbetrieb CAP Markt gemeinnÃ¼tzige GmbH',
'AllgÃ¤uer Kraftwerke GmbH',
'Am SÃ¼dharz GmbH',
'AMB Automobile Borna GmbH, NL BÃ¶hlen',
'Ambulanter Pflegedienst Angelika MÃ¼ller e.K.',
'Amt fÃ¼r ErnÃ¤hrung, Landwirtschaft und Forsten Roth',
'Amt HÃ¼ttener Berge, Gemeinde Ascheffel',
'AndrÃ¨ Lackner Einzelunternehmen',
'Andreas PfÃ¼ller - Autohaus Stollberg e.K',
'Ãœberlandwerk Erding GmbH & Co. KG',
'Ãœberlandwerk Leinetal GmbH',
'Ãœberlandwerk SchÃ¤ftersheim GmbH & Co. KG',
'Ãœberlandzentrale WÃ¶rth/Isar Altheim Netz AG',
'ÃœZ Mainfranken eG',
'Apartment H2 DÃ¼sseldorf',
'ArchitekturbÃ¼ro Seidel, Freiberufler',
'arcona Hotel ThÃ¼ringer Hof GmbH',
'Audi Zentrum Passau Erich RÃ¶hr GmbH & Co. KG',
'Auto BÃ¶deker GmbH',
'Auto Center AndrÃ© MÃ¼hlenbruch GmbH',
'Auto Center NordÂ GmbH',
'Auto KÃ¶hler GmbH & Co. KG',
'Auto KÃ¶nig GmbH & Co.KG',
'Auto KÃ¶nig GmbH&Co.KG',
'Auto KÃ¼hn GmbH',
'Auto RÃ¶hr Grafenau Ndl. d. Erich RÃ¶hr GmbH & Co. KG',
'Auto WÃ¼st GmbH',
'Auto-Ã–stringer GmbH',
'Auto-HÃ¤user GmbH & Co. KG',
'Auto-HÃ¼bner GmbH & Co. KG',
'Auto-Technik DÃ¤hne GmbH',
'Auto-TrÃ¶ndle GmbH & Co. KG',
'Auto-WÃ¼nsch KG',
'Autoarena MÃ¼nchen GmbH',
'Autodienst JahnsmÃ¼ller GmbH',
'AutoForum MÃ¼nchberg GmbH',
'Autohaus AllgÃ¤u GmbH & Co. KG',
'Autohaus am BrÃ¼ckentor GmbH & Co. KG',
'Autohaus BÃ¶hme GmbH',
'Autohaus BÃ¶ttche GmbH',
'Autohaus BÃ¤umer GmbH',
'Autohaus BÃ¼tje GmbH',
'Autohaus BaumgÃ¤rtel GmbH',
'Autohaus BeckhÃ¤user',
'Autohaus BrÃ¶mmler GmbH',
'Autohaus DÃ¶beln GmbH',
'Autohaus DÃ¼rkop GmbH',
'Autohaus Erlenhoff GmbH vorm. G.LÃ¶w',
'Autohaus Ernst MÃ¼ller GmbH & Co. KG',
'Autohaus FÃ¤rber GmbH',
'Autohaus FÃ¼llgraf & Partner Kyritz GmbH',
'Autohaus FrÃ¼chtl GmbH',
'Autohaus GÃ¶thling GmbH',
'Autohaus GÃ¶tz LadesÃ¤ule',
'Autohaus GrÃ¶pper GmbH',
'Autohaus GrÃ¼nhage',
'Autohaus GrÃ¼nhagen GmbH & Co KG',
'Autohaus GrÃ¼tzner GmbH',
'Autohaus Gretenkort GmbH ? Co. KG',
'Autohaus Gurrath Gmbh $ Co KG',
'Autohaus HÃ¶hentinger GmbH',
'Autohaus HÃ¶lzer GmbH',
'Autohaus HÃ¶rig GmbH',
'Autohaus HÃ¼bener GmbH',
'Autohaus Heemann eK Inh. JÃ¼rgen Heemann',
'Autohaus KÃ¶pf GmbH',
'Autohaus KÃ¼hne GmbH',
'Autohaus KÃ¼hnert GmbH & Co. KG',
'Autohaus Klaus HÃ¶rsting ek',
'Autohaus KnauÃŸ',
'Autohaus KrÃ¶ger',
'Autohaus KrÃ¶ger & Partner GmbH',
'Autohaus LÃ¤mmermann GmbH',
'Autohaus LÃ¼hrs GmbH',
'Autohaus MÃ¶ÃŸner GmbH',
'Autohaus MÃ¤rkisches Tor GmbH',
'Autohaus MÃ¼ller Eilenburg GmbH',
'Autohaus MÃ¼ller GmbH',
'Autohaus MÃ¼ller GmbH & Co. KG',
'Autohaus MÃ¼ller Leipzig',
'Autohaus MÃ¼ller Reudnitz GmbH',
'Autohaus MÃ¼ller Wurzen GmbH',
'Autohaus MarkÃ¶tter GÃ¼tersloh',
'Autohaus NÃ¶lscher GmbH',
'Autohaus PrÃ¼ller e.K.',
'Autohaus RÃ¤thel GmbH',
'Autohaus Raith, Riebold-RÃ¶sner-Raith GmbH',
'Autohaus Reiner FÃ¼tz GmbH & Co. KG',
'Autohaus SÃ¼dring GmbH',
'Autohaus SÃ¼dring GmbH & Co KG',
'Autohaus SchÃ¼ler & Co GmbH',
'Autohaus Schlutter GmbH Â  Hyundai VertragshÃ¤ndler',
'Autohaus Schmidt & SÃ¶hne',
'Autohaus Schmidt & SÃ¶hne Aschersleben GmbH & Co. KG',
'Autohaus Schmidt & SÃ¶hne GmbH',
'Autohaus Schmidt & SÃ¶hne GmbH & Co. KG',
'Autohaus SchrÃ¶er GmbH',
'Autohaus SpÃ¶rlein',
'Autohaus SteinbÃ¶hmer',
'Autohaus SteinbÃ¶hmer GmbH & Co. KG',
'Autohaus SteinbÃ¶hmer GmbH&Co.KG',
'Autohaus StrÃ¶bele GmbH',
'Autohaus StrauÃŸ GmbH',
'Autohaus TÃ¶nnemann GmbH & Co. KG',
'Autohaus VÃ¶ge e.K. Inh. E. Strobel',
'Autohaus WÃ¶ll e.K.',
'Autohaus WaldmÃ¼ller GmbH',
'Autohaus Walkenhorst IbbenbÃ¼hren GmbH',
'Autohaus WeingÃ¤rtner Miesbach GmbH & Co.KG',
'Autohaus Wilfried KÃ¼hnicke e.K.',
'Autohaus Witting & SÃ¶hne GmbH & Co. KG',
'Automobile KÃ¶pper GmbH',
'Automobilzentrum FÃ¼rstenwalde Nord GmbH',
'Autoreparatur SchÃ¶ne',
'AVP Sportwagen GmbH AlÃ¶tting',
'BÃ„RMAG Berlin Makler UG',
'BÃ¶hm Elektrobau, Inh. Martin BÃ¶hm',
'BÃ¶wing Energietechnik GmbH & Co. KG',
'BÃ¤ckerei LÃ¼ttel',
'BÃ¤ckerei Vatter',
'BÃ¼chelbergerei Chaletdorf',
'BÃ¼ckeberg-Klinik GmbH & Co. KG',
'BÃ¼rger Energie Drebach eG',
'BÃ¼rger Energie St. Peter eG',
'BÃ¼rger-Energie Genossenschaft Freisinger Land eG',
'BÃ¼rgerEnergie Niederbayern eG',
'BÃ¼rgerEnergie Rhein-Sieg eG',
'BÃ¼rgerEnergieGenossenschaft Kraichgau eG',
'BÃ¼rgerEnergieGenossenschaft Sottrum eG',
'BÃ¼rgerEnergieRheinMain eG',
'BÃ¼ttenpapierfabrik Gmund GmbH und Co. KG',
'Bau und Heimwerkermarkt MÃ¼llenhoff GmbH',
'Belia Seniorenresidenzen GmbH BetriebsstÃ¤tte Holthausen',
'Bernhard HÃ¼bner e.U.',
'Bertrandt Ing.-BÃ¼ro GmbH Tappenbeck',
'Berufsbildungszentrum am Nord-Ostsee- Kanal AÃ¶R',
'Best Western Plus Hotel BÃ¶ttcherhof',
'Best Western Plus Hotel FÃ¼ssen',
'Bezirkssparkasse Reichenau Anstalt des Ã¶ffentlichen Rechts',
'bioladen*Weiling',
'BMW AG Niederlassung MÃ¼nchen',
'BMW Autohaus MÃ¤rtin GmbH',
'BORMANN EDV+ZubehÃ¶r',
'BrÃ¤mswig Energie',
'BrÃ¼der Ley GmbH',
'BRK Kreisverband Kronach KdÃ¶R',
'BSH HausgerÃ¤te GmbH',
'BTB Blockheizkraftwerks- TrÃ¤ger- und Betreibergesellschaft mbH Berlin',
'Buchwinkler GmbH & Co. KG Volkswagen HÃ¤ndler',
'Burgunderhof digestifâ€™s GmbH',
'Business Park SÃ¼dbaar GmbH',
'Camping HarfenmÃ¼hle',
'Charming Appartements Hans-JÃ¼rgen Robert Straub',
'Christian LÃ¼hmann GmbH',
'computer weishÃ¤upl',
'Deutsche FunkturmÂ GmbH',
'Deutsche PrimÃ¤renergie GmbH',
'Deutsches Brennstoffinstitut VermÃ¶gensverwaltungs-GmbH',
'Dipl. Ing. H. RÃ¶der GmbH & Co. KG',
'DIT GÃ¶ttingen GmbH',
'DKB Stiftung Liebenberg GemeinnÃ¼tzige GmbH',
'dm-VermÃ¶gensverwaltungsgesellschaft mbH',
'DomÃ¤ne Schaumburg',
'Dr. Bernhard GÃ¶ttler',
'Dr. Bodo MÃ¼ller Gewerbe',
'DSD â€“ Duales System Services GmbH',
'E-Charge Geierlay (Freiberufler, FÃ¤rber Ing.-BÃ¼ro)',
'E-Tankstelle BaumhÃ¶gger',
'e.novum LÃ¼neburg gGmbH',
'E.RÃ¶hr',
'Ebbinghaus GrundstÃ¼cksverwaltungs GmbH & Co. KG',
'EDEKA Dirk MÃ¶ller e. K.',
'EDEKA KÃ¶nig',
'EDEKA KÃ¶rner',
'EDEKA Markt Kai GÃ¶bel',
'EFA Tankstellenbetriebe und MineralÃ¶lhandel GmbH',
'EG ElektromobilitÃ¤t GmbH & Co KG',
'EJW Tagungszentrum BernhÃ¤user Forst, KÃ¶rperschaft des Ã¶ffentlichen Rechts',
'Electric ELB GebÃ¤udetechnik GmbH',
'ElektrizitÃ¤ts-Werk Ottersberg',
'ElektrizitÃ¤tsgenossenschaft Rettenberg e.G.',
'ElektrizitÃ¤tsgenossenschaft Unterneukirchen eG',
'ElektrizitÃ¤tsgenossenschaft Wolkersdorf und Umgebung eG',
'ElektrizitÃ¤tsversorgung Werther GmbH',
'ElektrizitÃ¤tsversorgungsunternehmen (EVU) der Gemeinde Gochsheim',
'ElektrizitÃ¤tswerk Goldbach-HÃ¶sbach GmbH & Co. KG',
'ElektrizitÃ¤tswerk Hindelang eG',
'ElektrizitÃ¤tswerk Karl Stengle GmbH & Co. KG',
'ElektrizitÃ¤tswerk Mainbernheim GmbH',
'ElektrizitÃ¤tswerk Tegernsee',
'ElektrizitÃ¤tswerk WennenmÃ¼hle SchÃ¶rger KG',
'Elektro BrÃ¼nninger GmbH',
'Elektro KeÃŸler GmbH',
'Elektro MÃ¼hlbauer GmbH',
'Elektro-MÃ¼ller',
'Elektrotechnik SpÃ¤th',
'Elektrotechnik Waldemar MÃ¼ller GmbH & Co. KG',
'EMB Energieversorgung Miltenberg - BÃ¼rgstadt GmbH & Co. KG',
'EMERGY FÃ¼hrungs- und Servicegesellschaft mbH',
'EMI ElektroMobilitÃ¤tsInfrastruktur GmbH',
'Emil Frey KÃ¼stengarage GmbH',
'Energie H+ GmbH ? Co. KG',
'Energie SÃ¼dbayern GmbH'
)
;



select*
from charging_data3
;

-- Change the data type of inbetriebnahmedatum to date

alter table charging_data3
modify column inbetriebnahmedatum date;

select*
from charging_data3;














