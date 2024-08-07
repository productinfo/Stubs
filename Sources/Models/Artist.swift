//
//  Artist.swift
//  Stubs
//
//  Created by christian on 1/6/24.
//

import Foundation
import SwiftData

@Model
class Artist: Codable, Hashable {
    enum CodingKeys: String, CodingKey {
        case artistID = "idArtist"
        case artistName = "strArtist"
        case style = "strStyle"
        case genre = "strGenre"
        case mood = "strMood"
        case bio = "strBiographyEN"
        case geo = "strCountry"
        case artistImageURL = "strArtistThumb"
        case bannerImageURL = "strArtistFanart2"
        
    }
    
    var concerts: [Concert]?
    
    var artistID: String? = nil
    var artistName: String? = nil
    var style: String? = nil
    var genre: String? = nil
    var mood: String? = nil
    var bio: String? = nil
    var geo: String? = nil
    var artistImageURL: String? = nil
    var bannerImageURL: String? = nil
    
    // Image data is fetched after initialization
    @Attribute(.externalStorage) var artistImageData: Data?
    @Attribute(.externalStorage) var bannerImageData: Data?
    
    init(
        artistID: String? = nil,
         artistName: String? = nil,
         style: String? = nil,
         genre: String? = nil,
         mood: String? = nil,
         bio: String? = nil,
         geo: String? = nil,
         artistImageURL: String? = nil,
         bannerImageURL: String? = nil
    ) {
        self.artistID = artistID
        self.artistName = artistName
        self.style = style
        self.genre = genre
        self.mood = mood
        self.bio = bio
        self.geo = geo
        self.artistImageURL = artistImageURL
        self.bannerImageURL = bannerImageURL
        
    }
    
    // MARK: - Codable Conformance
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        artistID = try container.decodeIfPresent(String.self, forKey: .artistID)
        artistName = try container.decodeIfPresent(String.self, forKey: .artistName)
        style = try container.decodeIfPresent(String.self, forKey: .style)
        genre = try container.decodeIfPresent(String.self, forKey: .genre)
        mood = try container.decodeIfPresent(String.self, forKey: .mood)
        bio = try container.decodeIfPresent(String.self, forKey: .bio)
        geo = try container.decodeIfPresent(String.self, forKey: .geo)
        artistImageURL = try container.decodeIfPresent(String.self, forKey: .artistImageURL)
        bannerImageURL = try container.decodeIfPresent(String.self, forKey: .bannerImageURL)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encodeIfPresent(artistID, forKey: .artistID)
        try container.encodeIfPresent(artistName, forKey: .artistName)
        try container.encodeIfPresent(style, forKey: .style)
        try container.encodeIfPresent(genre, forKey: .genre)
        try container.encodeIfPresent(mood, forKey: .mood)
        try container.encodeIfPresent(bio, forKey: .bio)
        try container.encodeIfPresent(geo, forKey: .geo)
        try container.encodeIfPresent(artistImageURL, forKey: .artistImageURL)
        try container.encodeIfPresent(bannerImageURL, forKey: .bannerImageURL)
    }
    
    // MARK: - Hashable Conformance
    func hash(into hasher: inout Hasher) {
        hasher.combine(artistID)
    }
    
    static func ==(lhs: Artist, rhs: Artist) -> Bool {
        return lhs.artistID == rhs.artistID
    }
}

struct ArtistSearchResponse: Codable {
    let artists: [Artist]
}


// MARK: - Sample JSON Response
/*
 {
 "artists": [
 {
 "idArtist": "111239",
 "idLabel": "45114",
 "intBornYear": "1996",
 "intCharted": "3",
 "intDiedYear": null,
 "intFormedYear": "1996",
 "intMembers": "4",
 "strArtist": "Coldplay",
 "strArtistAlternate": "",
 "strArtistBanner": "https://www.theaudiodb.com/images/media/artist/banner/xuypqw1386331010.jpg",
 "strArtistClearart": "https://www.theaudiodb.com/images/media/artist/clearart/ruyuwv1510827568.png",
 "strArtistFanart": "https://www.theaudiodb.com/images/media/artist/fanart/spvryu1347980801.jpg",
 "strArtistFanart2": "https://www.theaudiodb.com/images/media/artist/fanart/uupyxx1342640221.jpg",
 "strArtistFanart3": "https://www.theaudiodb.com/images/media/artist/fanart/qstpsp1342640238.jpg",
 "strArtistLogo": "https://www.theaudiodb.com/images/media/artist/logo/urspuv1434553994.png",
 "strArtistStripped": null,
 "strArtistThumb": "https://www.theaudiodb.com/images/media/artist/thumb/uxrqxy1347913147.jpg",
 "strArtistWideThumb": "https://www.theaudiodb.com/images/media/artist/widethumb/sxqspt1516190718.jpg",
 "strBiographyCN": "酷玩樂團（英语：Coldplay）是成立於1997年、來自倫敦的英國另類搖滾樂團。團員包括克里斯·馬汀（主唱、鍵盤、吉他）、強尼·邦藍（主奏吉他）、蓋·貝瑞曼（貝斯吉他）及威爾·查恩（鼓、合音、其他樂器）。樂團最早成形於馬汀與邦藍就讀於倫敦大學學院 (UCL)時期。\n酷玩樂團的早期作品常被與電台司令、U2、傑夫·巴克利及崔維斯相提並論[1]。2000年，他們以單曲《Yellow》漸獲關注，隨後發行首張專輯《降落傘》，初試啼聲便在國際間大放異彩，並以該專輯獲水星音樂獎提名。2002年，酷玩樂團以第二張專輯《玩過頭》，奪得NME雜誌年度最佳專輯獎等多項大獎。酷玩樂團接著在2005年發行《XY密碼》專輯，雖然反應不如上述作品熱烈，但仍普遍獲得正面評價。2008年，酷玩樂團與製作人布萊恩·伊諾，推出第四張專輯《玩酷人生》，廣受好評，勇奪葛萊美等多項大獎[2]。2011年，他們繼續與布萊恩·伊諾合作，發行了第五張專輯《彩繪人生》，和之前的幾張專輯一樣取得了熱烈的反響。在全球，酷玩樂團已擁有超過五千萬的專輯銷售量[3]。\n自發行了《降落傘》後，酷玩樂團的每張專輯作品皆來有自各方的影響，如《玩過頭》的回聲與兔人合唱團[4]、凱特·布希、喬治·哈里森[5]與謬思合唱團[6]，《XY密碼》的強尼·凱許與發電廠樂團[7]，以及《玩酷人生》的布勒合唱團、拱廊之火樂團與我的血腥情人節合唱團[8]。酷玩樂團同時也積極投身於社會與政治組織活動，如樂施會的貿易要公平活動及國際特赦組織等。酷玩樂團亦參與演出各式慈善活動中，如Band Aid 20、現場八方、青少年癌症籌款音樂會等[9]。",
 "strBiographyDE": "Coldplay ist eine britische Pop-Rock-Band, bestehend aus Chris Martin, Jonny Buckland, Will Champion und Guy Berryman. Sie gehört zu den bekanntesten Vertretern des Britpop und ist eine der weltweit erfolgreichsten Bands des vergangenen Jahrzehnts. Die Band hat knapp 60 Millionen Tonträger weltweit verkauft, davon 40 Millionen Alben. Martin, Berryman, Buckland und Champion lernten sich als Studenten am University College London kennen und gründeten im September 1996 eine Band. Martin studierte Alte Geschichte, Buckland Mathematik, Astrophysik und Astronomie und Champion Anthropologie. Berryman studierte zunächst Ingenieurswissenschaften und später Architektur. Im Gegensatz zu allen anderen Bandmitgliedern schloss er kein Studium ab.\nChris Martin und Jonny Buckland, die sich in der Orientierungswoche am College kennenlernten, waren die ersten Mitglieder der Band. Sie spielten zunächst in einer Band namens „Pectoralz“, bis Guy Berryman, ein Klassenkamerad der beiden, hinzustieß. Ursprünglich gründeten die vier Mitglieder die Band unter dem Namen „Starfish“. Unter diesem Namen spielte die Band zunächst einige Gigs in kleineren Clubs in Camden. Phil Harvey, ein Studienkollege und Freund von Chris, wurde hierfür als Manager engagiert.\nIm März 1998 erschien die Safety EP, von der nur 500 Kopien veröffentlicht wurden. Diese diente größtenteils als Demo, sodass lediglich 50 Kopien in den offiziellen Verkauf gingen. Die EP ist somit eine Rarität und wird unter Sammlern enorm hoch gehandelt. Coldplay wurden daraufhin vom kleinen Independent-Label Fierce Panda Records unter Vertrag genommen. Die erste Veröffentlichung war die Brothers and Sisters EP, die im Februar 1999 in gerade einmal vier Tagen aufgenommen wurde.\nIm Frühling 1999 unterschrieben Coldplay einen Fünf-Alben-Vertrag bei Parlophone, wo sie bis heute unter Vertrag sind. Nach ihrem ersten Auftritt beim Glastonbury Festival ging die Band ins Studio, um ihre dritte EP The Blue Room aufzunehmen, von der im Oktober 5000 Stück in den Verkauf gingen. Bei der Produktion kam es zu Streitereien innerhalb der Band, sodass Champion durch Martin aus der Band geworfen wurde, jedoch kurz darauf wieder zurückgeholt wurde. Um weiteren Ärger zu vermeiden, beschlossen die vier, Regeln innerhalb der Band einzuführen: 1. Gewinne werden geteilt, 2. Drogenkonsum führt zum Ausschluss aus der Band.",
 "strBiographyEN": "Coldplay are a British alternative rock band formed in 1996 by lead vocalist Chris Martin and lead guitarist Jonny Buckland at University College London. After they formed Pectoralz, Guy Berryman joined the group as a bassist and they changed their name to Starfish. Will Champion joined as a drummer, backing vocalist, and multi-instrumentalist, completing the line-up. Manager Phil Harvey is often considered an unofficial fifth member. The band renamed themselves \"Coldplay\" in 1998, before recording and releasing three EPs; Safety in 1998, Brothers & Sisters as a single in 1999 and The Blue Room in the same year. The latter was their first release on a major label, after signing to Parlophone.\n\nThey achieved worldwide fame with the release of the single \"Yellow\" in 2000, followed by their debut album released in the same year, Parachutes, which was nominated for the Mercury Prize. The band's second album, A Rush of Blood to the Head (2002), was released to critical acclaim and won multiple awards, including NME's Album of the Year, and has been widely considered the best of the Nelson-produced Coldplay albums. Their next release, X&Y, the best-selling album worldwide in 2005, was met with mostly positive reviews upon its release, though some critics felt that it was inferior to its predecessor. The band's fourth studio album, Viva la Vida or Death and All His Friends (2008), was produced by Brian Eno and released again to largely favourable reviews, earning several Grammy nominations and wins at the 51st Grammy Awards. On 24 October 2011, they released their fifth studio album, Mylo Xyloto, which was met with mixed to positive reviews, and was the UK's best-selling rock album of 2011.\n\nThe band has won a number of music awards throughout their career, including seven Brit Awards winning Best British Group three times, four MTV Video Music Awards, and seven Grammy Awards from twenty nominations. As one of the world's best-selling music artists, Coldplay have sold over 55 million records worldwide. In December 2009, Rolling Stone readers voted the group the fourth best artist of the 2000s.\n\nColdplay have been an active supporter of various social and political causes, such as Oxfam's Make Trade Fair campaign and Amnesty International. The group have also performed at various charity projects such as Band Aid 20, Live 8, Sound Relief, Hope for Haiti Now: A Global Benefit for Earthquake Relief, The Secret Policeman's Ball, and the Teenage Cancer Trust.",
 "strBiographyES": "Coldplay es una banda británica de rock alternativo formada en Londres en 1996. El grupo está integrado por Chris Martin (voz, teclado, guitarra), Jon Buckland (guitarra principal), Guy Berryman (bajo eléctrico) y Will Champion (batería, coros y otros instrumentos). Los primeros trabajos de Coldplay hicieron que la banda fuera comparada repetidas veces con artistas como Oasis, Radiohead, INXS, U2 y Travis. Alcanzaron el éxito internacional con el lanzamiento de su sencillo «Yellow», seguido por su álbum de debut, Parachutes (2000), que fue nominado a los Premios Mercury. Su segundo álbum, A Rush of Blood to the Head (2002) ganó múltiples premios, incluido el de Álbum del Año según el semanario NME. Pese a que su tercer álbum, X&Y (2005) no causó tanto entusiasmo, tuvo igualmente una recepción positiva. El cuarto álbum de estudio de la banda, Viva la Vida or Death and All His Friends (2008) fue producido por Brian Eno y generó excelentes críticas, llegando a recibir nominaciones a los premios Grammy y otra clase de homenajes. Coldplay ha vendido internacionalmente 50 millones de copias.\nTras el lanzamiento de Parachutes, la banda recibió la influencia de otros artistas, tales como Kate Bush, U2, George Harrison, y Muse en A Rush of Blood to the Head, Johnny Cash en X&Y y Blur y Arcade Fire en Viva la Vida. Coldplay ha sido siempre un grupo defensor activo de varias causas políticas y sociales como la campaña de Oxfam Make Trade Fair y Amnistía Internacional. Además han participado en muchos proyectos de caridad como Band Aid 20, Live 8, Sound Relief, Hope for Haiti Now: A Global Benefit for Earthquake Relief y Teenage Cancer Trust. Su nuevo álbum, Mylo Xyloto debutó en el número 1 en 21 países. Debutando también en UK con 208.000 copias, muy lejos de su álbum antecesor Viva la Vida or Death and All His Friends. Hasta la fecha el álbum ha vendido más de 6 millones copias, siendo el mejor álbum de rock vendido a nivel mundial desde el anterior álbum de la banda publicado en 2008.",
 "strBiographyFR": "Coldplay est un groupe de rock britannique formé à Londres en 1996 par le chanteur, guitariste et pianiste Chris Martin et le guitariste Jon Buckland. Le bassiste Guy Berryman rejoint ensuite la formation, qui prend le nom de Starfish avant que le batteur Will Champion devienne membre à son tour et que le producteur Phil Harvey s'associe avec eux dans leur entreprise3. En 1998, le groupe voit le jour sous son appellation définitive et sort deux premiers EPs. Ils en profitent alors pour signer chez le label Parlophone2.\nAvec cinq albums studio publiés, le dernier étant Mylo Xyloto, sorti le 24 octobre 20114, Coldplay est aujourd'hui l'un des plus grands groupes à succès du nouveau millénaire avec près de 60 millions d'albums vendus5. Critiqué mais régulièrement récompensé, le groupe a remporté 8 Brit Awards, 7 Grammy Awards, 6 Q Awards et 5 NME Awards. Il est aussi élu en décembre 2009, quatrième meilleur artiste des années 2000 par les lecteurs du magazine Rolling Stone6.\nLe groupe prend cause dans différentes œuvres caritatives et officie depuis ses débuts pour le commerce équitable aux côtés d'Oxfam international7 et d'Amnesty International8. Cet engagement les conduit à participer à des groupes caritatifs tels que Band Aid 20 et à jouer dans des concerts tels que le Live 8, le Fairplay7, le Sound Relief, le Hope for Haiti Now7 ou le Teenage Cancer Trust9. Chris Martin et Jonny Buckland se rencontrent en septembre 1996 à l’University College de Londres. Les deux amis, passionnés de musique, passent le reste de l'année universitaire à la planification d'un groupe, finalement appelé Pectoralz. Ils sont bientôt rejoints par Guy Berryman, qui étudie à la même université. Le groupe est formé en 1997. Un ami de Chris Martin, Phil Harvey, est engagé comme manager. Le 8 janvier 1998, ils recrutent un quatrième membre, Will Champion qui devient le batteur alors qu’il n'a jamais touché une batterie de sa vie. A peine engagé, Will Champion organise le premier concert du groupe au Laurel Tree de Londres. Pour ce concert donné le 16 janvier 1998, ils se baptisent provisoirement Starfish10.\nLe nom Coldplay est proposé par Tim Crompton11, un ami commun d'université qui a d'abord imaginé ce nom pour son propre groupe, avant de l'abandonner, le trouvant trop déprimant. Chris Martin et ses acolytes trouvent ce nom parfait et décident de le garder.",
 "strBiographyHU": "A Coldplay egy angol alternatív rockegyüttes, amely 1998 januárjában alakult. Tagjai: Chris Martin énekes-gitáros-zongorista, Jonny Buckland gitáros, Guy Berryman basszusgitáros és Will Champion dobos. Több mint 30 millió lemezt adtak el és olyan ismert slágereik vannak, mint például a Yellow, a Scientist, a Speed of Sound, Grammy-díjas Clocks, vagy a az ötödik stúdióalbumukról a \"Paradise\" . Az együttes egyébként jelenleg hét Grammy-díj birtokosa.\nVilághírnévre a Yellow című dalukkal tettek szert, melyet debütáló albumuk, a Parachutes (2000) követett. 2002-ben jelent meg második albumuk A Rush of Blood to the Head címmel, amelyet a Rolling Stone magazin beválasztott minden idők 500 legjobb albuma közé. A következő stúdióalbumuk, az X&Y (2005) talán kevésbé lelkes, de még mindig pozitív fogadtatásban részesült. Negyedik stúdióalbumuk, a Viva la Vida or Death and All His Friends (2008), melynek társproducere Brian Eno volt, ismét pozitív fogadtatásra talált, az ötödik stúdióalbumukat, a \"Mylo Xyloto\"-t (2011), pedig egy kisebb stílus váltás jellemez.",
 "strBiographyIL": "קולדפליי (באנגלית: Coldplay) היא להקת פופ רוק בריטית מצליחה, שנוסדה בשנת 1998 ומכרה מעל ל-40 מיליון תקליטים. סגנון המוזיקה, השירה והלחנים של הלהקה מכילים מאפיינים רבים המזוהים עם תת-הז'אנר בריטפופ, פוסט-בריטפופ ורוק אלטרנטיבי. חברי הלהקה נפגשו בשנת 1996 באוניברסיטת UCL בלונדון, ודי מהר גילו את החיבה המשותפת שלהם למוזיקה. הם ניגנו יחד מספר פעמים כתחביב, עד שהחליטו להקים להקה. את השם קולדפליי לקחו מחבר אחר שלהם שהגה אותו כשחשב בעצמו להקים להקה, דבר שלא יצא לפועל. קולדפליי ניגנו במועדונים ברחבי לונדון ובמאי 1998 נכנסו לאולפן הקלטות והקליטו ב-200 פאונד את האי.פי. Safety, שיועד להפצה בין חברות התקליטים. לאחר ההקלטה הלהקה הייתה כה מרוצה מהתוצאה, שהחליטה לשכפל עוד 500 עותקים מהשיר ולהפיץ אותם בין אנשים מהתעשייה, תחנות רדיו ובעיקר חברים ובני משפחה נלהבים. ההופעות שלהם במועדונים גרמו לכך שעיתונאי המוזיקה הבחינו בהם ובסוף 1998 הוכרזו קולדפליי על ידי מגזין המוזיקה הבריטי NME כאחת ההבטחות של 1999.\nבאפריל 1999 הוציאו סינגל בשם \"Brothers And Sisters\" אשר צד את אוזנו של אחד השדרים ב-\"Radio 1\" של הבי.בי.סי, שניגן את השיר שוב ושוב ובכך עזר להתקדמות השיר שבסופו של דבר נכנס למצעד הבריטי והגיע למקום ה-95. חברות התקליטים החלו להביע התעניינות ובקיץ 1999 נחתם חוזה עם חברת התקליטים \"פרלפון\". קולדפליי הופיעו במהלך קיץ זה בפסטיבלים רבים לצד להקות ידועות יותר, ביניהן קטטוניה. חברת התקליטים התעקשה שהלהקה תוציא עוד סינגלים לפני שחבריה נכנסים לאולפן כדי להקליט אלבום וכך הם הוציאו את \"Blue Room\", את \"Bigger Stronger\". כבר אז החלו ההשוואות של קולדפליי לרדיוהד של תקופת OK Computer. הלהקה טענה, מצידה, שהשירים האלה נכתבו זמן רב לפני שרדיוהד הוציאו את האלבום המדובר.",
 "strBiographyIT": " Coldplay sono un gruppo alternative rock britannico formatosi a Londra nel 1997. La band è composta da Chris Martin (voce, tastiere, chitarra), Jonny Buckland (chitarra), Guy Berryman (basso) e Will Champion (batteria). I Coldplay raggiunsero la fama mondiale con il loro singolo Yellow, contenuto nel loro album di debutto Parachutes (2000). Il brano diventò presto una hit e nel luglio 2000 arrivò a piazzarsi alla quarta posizione della classifica dei singoli britannica. Il loro secondo album A Rush of Blood to the Head (2002) segna la loro consacrazione e consente alla band di acquisire notorietà in tutto il mondo. L'album si piazzò direttamente al 1º posto della UK Albums Chart e al 5º posto della Billboard 200. La loro successiva pubblicazione, X&Y (2005) ricevette una fredda accoglienza da parte della critica, ma riuscì comunque a tenere i ritmi di vendita dei precedenti album. Con il loro quarto album in studio Viva la Vida or Death and All His Friends, trainato dalla hit Viva la vida e prodotto da Brian Eno, la band ottenne numerose recensioni favorevoli, oltre alla vittoria di tre Grammy. I Coldplay con il loro quarto album in studio hanno raggiunto il traguardo dei 50 milioni totali di dischi venduti.\n\nLo stile dei Coldplay del periodo Parachutes è comparabile con quello dei Radiohead, degli U2, dei Travis e a quello di Jeff Buckley.[9] Per A Rush of Blood to the Head, i Coldplay si rifanno a stili più similari a The Beatles, Echo & the Bunnymen, Kate Bush e George Harrison; per X&Y vengono influenzati da Johnny Cash e Kraftwerk, mentre si basano sullo stile dei Blur, degli Arcade Fire e dei My Bloody Valentine per Viva la Vida or Death and all his Friends.\n\nLa band ha anche molto a cuore le questioni politiche e sociali del mondo, sono impegnati attivamente nella causa portata avanti da Oxfam ed hanno sostenuto altre importanti cause suonando in concerti come il Live 8 e partecipando al Band Aid.",
 "strBiographyJP": "大衆性を強く持つ楽曲が多く、現在の音楽シーンにおいて最も大きな商業的成功を得ているバンドの一つである。 1997年にロンドンで結成される。メンバーは、クリス・マーティン（ボーカル・ギター・ピアノ）、ジョニー・バックランド（ギター）、ガイ・ベリーマン（ベース）、ウィル・チャンピオン（ドラム）から構成される。メンバー4人とも教師の息子たちである。\n2000年、デビュー・アルバム『パラシューツ』とシングル「Yellow」の大ヒットにより世界的な成功を得た。現在までに総計6600万枚以上のアルバムを売り上げ、2000年代における最も成功したバンドのひとつである。『パラシューツ』は全世界で約950万枚、2ndアルバム『静寂の世界』は約1400万枚、3rdアルバムとなる『X&Y』は約1000万枚のセールスを記録した。ブライアン・イーノをプロデューサーに迎えた4枚目となるスタジオ・アルバム、『美しき生命』は2008年6月にリリースされ、約3,300万枚の大ヒットを記録した。「イエロー」、「スピード・オブ・サウンド」や2003年にグラミー賞「最優秀レコード賞」を受賞した「クロックス」、さらに最新シングル「美しき生命」といった数多くのヒット曲があることで知られる。\nコールドプレイはさまざまなアーティストの影響を受けている。ギターとファルセットボーカル中心の曲が多いレディオヘッドやトラヴィスをはじめ、U2からも強い影響を受けているとされる。『パラシューツ』以降は他方面からの影響を得たとされ、『静寂の世界』ではエコー&ザ・バニーメンやジョージ・ハリスン、『X&Y』ではジョニー・キャッシュからの影響やクラフトワーク的作風にも挑戦している。\nコールドプレイはフェアトレードやアムネスティ・インターナショナルなどの社会的・政治的運動を活発に支持している。さらにバンド・エイドやLIVE 8などの慈善コンサートにおいても公演を行っている。",
 "strBiographyNL": "Coldplay is een Britse alternatieverockband, die in 1996 in Londen werd gevormd. De leden zijn zanger Chris Martin, gitarist Jonny Buckland, drummer Will Champion en bassist Guy Berryman.\n\nIn het begin werd Coldplay vergeleken met andere artiesten en bands, waaronder Radiohead, U2 en Travis. De band brak met de single Yellow door, gevolgd door hun debuutalbum Parachutes (2000). A Rush of Blood to the Head (2002), het tweede album, betekende hun definitieve doorbraak. Het album won ook meerdere prijzen. In 2005 kwam het album X&Y, dat in zestien landen op nummer één kwam. Het vierde album, Viva la Vida or Death and All His Friends, werd samen met Brian Eno geproduceerd en ontving meerdere Grammy's. Hun vijfde album Mylo Xyloto is tevens weer geproduceerd door Eno. Grote hits van Coldplay zijn onder meer Speed of Sound, Clocks, Yellow, Viva La Vida, Talk, Fix You en Paradise.",
 "strBiographyNO": "Coldplay er et britisk band som spiller alternativ rock, dannet i London, England i 1998. Gruppen består av vokalist/pianist/gitarist Chris Martin, sologitarist Jonny Buckland, bassist Guy Berryman og trommeslager/multiinstrumentalist Will Champion. Coldplay har solgt over 40 millioner plater på verdensbasis, og er kjent for hitlåter som «Yellow», «The Scientist», «Clocks», «Speed Of Sound», «Fix You» og «Viva La Vida».\n\nColdplays gjennombrudd kom med singelen «Yellow» fra debutalbumet Parachutes i år 2000, og albumet ble nominert til Mercury Prize. Oppfølgeren, A Rush Of Blood To The Head, kom i 2002 og ble en stor suksess. Albumet vant diverse priser, blant annet NME sin pris for årets album. Bandets neste utgivelse, X&Y ble utgitt tre år senere, til omtrent samme respons som forløperen. Coldplays fjerde album, Viva la Vida or Death and All His Friends, fra 2008 ble produsert av Brian Eno og fikk særdeles god kritikk, og ble nominert til flere Grammy-priser. Bandets femte album, Mylo Xyloto, ble sluppet ut 24. oktober 2011. Alle Coldplays album har nytt kommersiell suksess.",
 "strBiographyPL": "Coldplay – brytyjska grupa muzyczna, grająca rock alternatywny. Członkowie zespołu są zaangażowani także w działalność społeczno-polityczną.\n\nColdplay ma na koncie ponad 50 milionów sprzedanych płyt oraz liczne nagrody branży muzycznej.",
 "strBiographyPT": "Coldplay é uma banda de rock alternativo britânica formada em 1996 pelo vocalista Chris Martin eo guitarrista Jonny Buckland no University College London. Depois de formado Pectoralz, Guy Berryman se juntou ao grupo como baixista e eles mudaram o nome para Starfish. Will Champion entrou como baterista, backing vocal e multi-instrumentista, completando o line-up. Gerente de Phil Harvey é muitas vezes considerado um quinto membro não oficial. A própria banda \"Coldplay\" rebatizado em 1998, antes de gravar e lançar três EPs; Segurança em 1998, Brothers & Sisters como um single em 1999 e The Blue Room, no mesmo ano. O último foi o primeiro lançamento em uma grande gravadora, depois de assinar com a Parlophone.\nEles alcançaram a fama mundial com o lançamento do single \"Yellow\", em 2000, seguido por seu álbum de estréia lançado no mesmo ano, Parachutes, que foi indicado para o Mercury Prize. O segundo álbum da banda, A Rush of Blood ao Chefe (2002), foi lançado para aclamação da crítica e ganhou vários prêmios, incluindo Álbum do Ano da NME, e tem sido amplamente considerado o melhor dos álbuns do Coldplay Nelson produzidos. Seu próximo lançamento, X & Y, o álbum mais vendido em todo o mundo em 2005, foi recebido com críticas positivas sobre o seu lançamento, embora alguns críticos sentiram que era inferior ao seu antecessor. O quarto álbum de estúdio da banda, Viva la Vida ou Morte e Todos os Seus Amigos (2008), foi produzido por Brian Eno e lançado novamente para comentários amplamente favoráveis, ganhando várias indicações ao Grammy e vitórias no Grammy Awards 51. Em 24 de outubro de 2011, eles lançaram seu quinto álbum de estúdio, Mylo Xyloto, que foi recebido com misto de comentários positivos, e foi best-seller álbum de rock do Reino Unido de 2011.\nA banda já ganhou vários prêmios ao longo da sua carreira, incluindo sete Brit Awards ganhando Melhor Grupo Britânico três vezes, quatro MTV Video Music Awards, e sete Prêmios Grammy de vinte indicações. Como um dos artistas da música mais vendidos do mundo, o Coldplay já venderam mais de 55 milhões de discos em todo o mundo. Em dezembro de 2009, do Rolling leitores Pedra votado o grupo a quarta melhor artista da década de 2000.\nColdplay tem sido um apoiante activo de várias causas sociais e políticas, como a campanha Make Trade Fair da Oxfam e Anistia Internacional. O grupo também participou de vários projetos de caridade como o Band Aid 20, Live 8, Sound Relief, Hope for Haiti Now: A Benefit Global para Earthquake Relief, Bola do Secret Policeman, eo Teenage Cancer Trust.",
 "strBiographyRU": "«Coldplay» (произносится как Колдплэ̀й) — британская рок-группа. Начав играть осенью 1996 года, и выпустив свою первую демо-запись Safety в 1998 группа пошла по дороге славы, но настоящего успеха в мире Coldplay добились только в 2000 году, после выхода их второго сингла «Yellow» из альбома Parachutes, ворвавшегося на вершины всех чартов Великобритании и Соединённых Штатов Америки. Альбомы Coldplay разошлись тиражом более 80 миллионов экземпляров.\n\nГруппа принимала участие в различных социальных проектах, таких как Band Aid 20, Live 8, кампании в поддержку детей, больных раком. Также Coldplay выступили на закрытии паралимпийских игр 2012 в Лондоне.\n\nУчастники Coldplay являются активными сторонниками различных социальных и политических кампаний, в частности Оксфэм — Make Trade Fair и Международной Амнистии.\n\nВ декабре 2012 года портал Last.fm назвал Coldplay лучшим исполнителем за 10 лет скробблинга.\n\nColdplay получали премию Грэмми за все альбомы, кроме A Rush of Blood to the Head. Песни «In My Place» (в 2003 году), «Speed of Sound» (в 2006), «Talk» (в 2007), «Viva la Vida» (в 2009), «Life in Technicolor II» (2009), «Paradise» (в 2012), «Every Teardrop Is a Waterfall» (в 2012) и «Charlie Brown» (в 2013) Coldplay также получили или были номинированы на премии Грэмми.",
 "strBiographySE": "Coldplay, är ett brittiskt rockband som bildades 1996 i University College London.\n\nBandmedlemmarna Chris Martin (gitarr, vokalist, piano/keyboards), Guy Berryman (bas), Jonny Buckland (gitarr, kör) och Will Champion (trummor, kör) träffade varandra som studenter på University College London.\n\nBandet har sålt över 60 miljoner skivor över hela världen, varav ”A Rush of Blood to the Head” som deras mest sålda skiva, med över 16 miljoner sålda skivor och fick 9 plantinum i hemlandet Storbritannien.\n\nBandet släppte tre EP:s innan debutalbumet Parachutes kom ut. Dessa heter The Safety EP, Brothers and sisters och The Blue Room. Med låten Yellow fick de sitt genombrott och har på senare tid (framförallt med albumet X&Y som är mer arenarock än de tidigare) blivit jämförda med bland andra U2 och Radiohead. Själva säger sig Coldplay ha inspirerats musikaliskt till stor del av grupper såsom U2 och norska a-ha.\n\nColdplay hette till en början Starfish. Några kompisar till Guy, Jon, Chris och Will hade ett band som hette Coldplay, så när de bytte namn så överläts namnet till dåvarande Starfish som alltså blev Coldplay. De fick namnet av sina kompisar eftersom de tyckte att de lät ”alltför deprimerande”. ",
 "strCountry": "London, England",
 "strCountryCode": "GB",
 "strDisbanded": null,
 "strFacebook": "www.facebook.com/coldplay",
 "strGender": "Male",
 "strGenre": "Alternative Rock",
 "strLabel": "Parlophone",
 "strLastFMChart": "http://www.last.fm/music/Coldplay/+charts?rangetype=6month",
 "strLocked": "unlocked",
 "strMood": "Happy",
 "strMusicBrainzID": "cc197bad-dc9c-440d-a5b5-d52ba2e14234",
 "strStyle": "Rock/Pop",
 "strTwitter": "www.twitter.com/coldplay",
 "strWebsite": "www.coldplay.com"
 }
 ]
 }
 */
