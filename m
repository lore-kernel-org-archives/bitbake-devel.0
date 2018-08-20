Return-Path: <karstens@graphcore.ai>
X-Greylist: delayed 39678 seconds by postgrey-1.34 at layers.openembedded.org;
	Tue, 21 Aug 2018 00:26:47 UTC
Received: from EUR01-HE1-obe.outbound.protection.outlook.com
	(mail-he1eur01on0132.outbound.protection.outlook.com [104.47.0.132])
	by mail.openembedded.org (Postfix) with ESMTP id 02AD27907E
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 21 Aug 2018 00:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=graphcore.onmicrosoft.com; s=selector1-graphcore-ai;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=sUf6w/xY9Z0eUIjBPWVfy/BjuxWNObgec3n4YxCznVI=;
	b=ZlM1oPT/uefa9wqAT+FME3AwETX4dq0N7FuaHVokNP4INmARrhtRp3ytN896hVaejm15OaDuPlC8G880zxLM5xoMFoP+D+881DQXHw6CCwGK8lDumIw60q2QNtTfk7yjiKmF8ro3cIKxsk1+V2gAZJifWJ4PL8536feCc2IIYD8=
Authentication-Results: spf=none (sender IP is )
	smtp.mailfrom=karstens@graphcore.ai; 
Received: from hansa.oslo.graphcore.ai (95.130.222.83) by
	DB3PR0102MB3673.eurprd01.prod.exchangelabs.com (2603:10a6:8:5::15) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.1059.20;
	Mon, 20 Aug 2018 07:52:32 +0000
From: Karsten Strand <karstens@graphcore.ai>
To: bitbake-devel@lists.openembedded.org
Date: Mon, 20 Aug 2018 09:51:00 +0200
Message-Id: <1534751460-20687-1-git-send-email-karstens@graphcore.ai>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
X-Originating-IP: [95.130.222.83]
X-ClientProxiedBy: LO2P265CA0229.GBRP265.PROD.OUTLOOK.COM
	(2603:10a6:600:b::25) To DB3PR0102MB3673.eurprd01.prod.exchangelabs.com
	(2603:10a6:8:5::15)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99612a94-26f9-40b4-58e0-08d60671e2ce
X-Microsoft-Antispam: BCL:0; PCL:0;
	RULEID:(7020095)(4652040)(7021125)(8989137)(4534165)(7022125)(4603075)(4627221)(201702281549075)(8990107)(7048125)(7024125)(7027125)(7028125)(7023125)(5600074)(711020)(2017052603328)(7153060)(7193020);
	SRVR:DB3PR0102MB3673; 
X-Microsoft-Exchange-Diagnostics: 1; DB3PR0102MB3673;
	3:IJ7OxlKfgnsMzlRjXCZaANBurD44dCkF622yRG0EjmcWwVSw4uUq0dmWDv2s3A7xz+hdWMCptsUgyZYyYuLo9kNf0Xzh+F9VbyU2kqcBOsW33Lo95JZ/oPtwawCXsjr9WNEm04qy0ufzC8W1D2qM2YJEazTO3OX53r8i6ygHlYimiXGLhNCPvSXYgZgVyVPpZAmoyM4TO5VKyGFvvkIAIsZ0IP6ZUtAnnxxTOp6imAEuEY6TDIaxBdY+AHn1hQYy;
	25:hjLOYe9yd4XmzRxw/f4nx18dYGqn6MoydRZv3zqmvo/7RU61uuFePDOPZJ7A3pRIARqVXMXotbhcB1hckEgnPPKZfsF976097w+nJXgV9JTUr0oohN8cZ+TZOsTGxG8o+At8SAJVXMFDjw92sT8DgYZ51FeyfszaOCn30uMNxQqU4wfB81EZJ/7J2DANIjtwVsVT0Z50pkD2G5PlYHQR8vKJ/Kl458s++uUVJzVF5xIpJsd1Hn3blKIubOt8v9ZhGc8bUi0DpHoKUZ/vhLTRm4ZuFQWpXAr3whjhnwja6aNjBZWU/RP+1RCEhRGL6RtXdkEv2cdFBwoFTSFWBnal2w==;
	31:MaecmLsxyLuA3l/JP+nHNJnwpG9F5r+BISXI/O91diERWhMTdqwrf/6gBxpw/hlM6AhVmVKP3CzMRYHSYxUH8HwEUhs3rfZCDGDRB0H+fILLXQB0EX3FlEB/ATb1Xjg/qY6WdtwI7C/GGFu4ggThe6ywZKQgipBXVbj8vncjbiFDhouDFalatkOHOR1QnO5L1ZPmRRBSfBY8TduTxsM6S7mdD8+0BRc6xOaNAKurfas=
X-MS-TrafficTypeDiagnostic: DB3PR0102MB3673:
X-Microsoft-Exchange-Diagnostics: 1; DB3PR0102MB3673;
	20:h2TlnlHgltGUAcen2x6aHfdi+2zeARgOVmFQbZG0qQE46S6BDUAYLjEpMOMXOV94lwD6WIQWQ6tmRC1rwtN2BQfl1+HeyTj+d9+XtHrztPhVJO8HV8qH+8h2W6T02HX0zkzmEFYiN/sF8jx8c123QSfTrUiM56l/IjW8+bJQwkyIfSOoRWCoos/uP5jTA5xjFbuvs3B3YuSWr2KeUZ92s/50+6mQ1lcK978o1PQsYY4cfR3ol34kJvFIttKDNgpCTUXNaYeRcueOXHTYj+A36TSQXNdGgXe9ee0fmFe5CLK8raZ7RHRXDyn0dno24qS1RfeadDxWddbepSPf/wzEZ8rpshj54chSKU4bgPPNFXSqxOTvZRUmSRArDQlGS7dzibEhtImkPiHCLNAtMq6sxVF8+kLefgtfx6i6HCHoXLHtgaNpsmlXYn31mYCoDqhtbhG/OdznPRfhdEoDIj/FEaRm+uyu4UQchmK5D3uw1g+v9qEDZMwuFo9liT/Eam51;
	4:n+LdmI0egCAws7kp6CAPx8NPdNmeZVaDXZ3ooJvOqaHK9yvGY1ErAzhcv+VoKm0pGdjN/v9Ye0PEa09DkPKxOBUik0OwOkLYvxf811NNLOugWvBDiuVvuRdHUl1Ooc6WElk9CaRjetcTRTuBTCHP16Q9EleTWKXHKIGNMCsDmjE6ay+Kkc2vid1+nAE/yEpdmUK7xSuhaO9w1HuTFt7pYWJjVQ8HTshNzwy/x9OAwaMZMyfpXxT1yulSqP4cIgVfNmbWwhQghQ0KywyA28WPvg==
X-Microsoft-Antispam-PRVS: <DB3PR0102MB36735F800C44145D301DA892AC320@DB3PR0102MB3673.eurprd01.prod.exchangelabs.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-MS-Exchange-SenderADCheck: 1
X-Exchange-Antispam-Report-CFA-Test: BCL:0; PCL:0;
	RULEID:(8211001083)(6040522)(2401047)(5005006)(8121501046)(3231311)(944501410)(52105095)(10201501046)(93006095)(93001095)(3002001)(149027)(150027)(6041310)(2016111802025)(20161123560045)(20161123558120)(20161123562045)(20161123564045)(6043046)(201708071742011)(7699016);
	SRVR:DB3PR0102MB3673; BCL:0; PCL:0; RULEID:;
	SRVR:DB3PR0102MB3673; 
X-Forefront-PRVS: 0770F75EA9
X-Forefront-Antispam-Report: SFV:NSPM;
	SFS:(10019020)(346002)(136003)(366004)(39830400003)(376002)(396003)(199004)(189003)(2351001)(53936002)(25786009)(4326008)(97736004)(107886003)(305945005)(316002)(478600001)(68736007)(7736002)(81156014)(8676002)(81166006)(486006)(36756003)(956004)(476003)(1857600001)(86362001)(105586002)(106356001)(14444005)(2616005)(26005)(236005)(7696005)(52116002)(2361001)(50226002)(3846002)(74482002)(6486002)(51416003)(2906002)(5660300001)(6916009)(16586007)(48376002)(6666003)(386003)(66066001)(186003)(6116002)(16526019)(47776003)(50466002)(8936002);
	DIR:OUT; SFP:1102; SCL:1; SRVR:DB3PR0102MB3673;
	H:hansa.oslo.graphcore.ai; FPR:; SPF:None; LANG:en;
	PTR:InfoNoRecords; A:1; MX:1; 
Received-SPF: None (protection.outlook.com: graphcore.ai does not designate
	permitted sender hosts)
X-Microsoft-Exchange-Diagnostics: =?us-ascii?Q?1; DB3PR0102MB3673;
	23:ixvwzuOHR+Yj7c4kn61hao4qK6YCkGhNCphVDyi?=
	=?us-ascii?Q?3QMgoAdpjkd/X42QARQNiWKtoSuFa27Tg7KWpq89gHOyNgd3iDAyNVFOTLtA?=
	=?us-ascii?Q?MUzNc0BUnzl1KBdlOfHVFThJ0f/LJNsJpU4hdyqudfIwOvfGrSzldKJmdhX1?=
	=?us-ascii?Q?PRjEyD4U7BwCA5uK36fZuF5t5QVITpj91KfOVJVJjXYCcuXdTy5t07KcN75G?=
	=?us-ascii?Q?mao90nZjeot00mJBDPR0QrhhDn+Hp93HdZsa/EK1fgrf2bXzTgUqHTQ/gRCE?=
	=?us-ascii?Q?PgxBN5MRFk35yu6mb8ge/y1/t16dF6/WALOqRz2MelZr5BSLXPDmf+j3uF8V?=
	=?us-ascii?Q?wcVFocfEHqpiG9vmZcn4QYL+gVaHfyqbZt/Dps4iwSC++KzjOzrJDIvFtXME?=
	=?us-ascii?Q?VQCRpsB1U7bi7Kz0PvWYdGhYE3EuGR3rxgP+ZbBjtzis44Adc58CVEBAzn9s?=
	=?us-ascii?Q?MmAqRviWL8jp3Jag4QvSdE5WTxQrnWMXkmR80cjAcedgsFjrd4Diz0bPBQye?=
	=?us-ascii?Q?1G4dvetjLDkYJI7LqAInsRV632OPWtG0u+sGsG0+7neY/Ljvkgz6/G1uXtJB?=
	=?us-ascii?Q?AP+nBTPAdn4Uk8rqPBcHDQaSmrTSoQMkZ/9RvzAgpRRnSSEEAIGU4uP4C7D9?=
	=?us-ascii?Q?D8/Ccq0UIcgCoolo6wf4ITyWafSWJOjAO+Zt8ms2ouHG/bdQhZub0rvjgiYY?=
	=?us-ascii?Q?fUcKJrg7cZ3CKFGxWw7pC3D6Rx3jpnchW4/MKJfFAT6HwxIf3+M0WTgQANSK?=
	=?us-ascii?Q?8jMq6tTogjgHm9vGZ5PnKsYGQi/PAEvsIMrZRCWM45opJXU2V+Uj91zFeUZZ?=
	=?us-ascii?Q?TyhaQ0hCc1anhOCEMd/i0ASL3lQusFCs+bWT6XYugGkWqiDzfNvxcs8rhe3I?=
	=?us-ascii?Q?n+efqDn3QPZ294PTqHxRlSKHHd2vtEMyCpz2ZCZAQFUwtPtwbleqsjWF5Er8?=
	=?us-ascii?Q?xIaChtE68iDdfmM4Abm/fHwvWCpq10FliXqpCDmQPMzCCP57EkpInsQdzXnt?=
	=?us-ascii?Q?0v/G6zqUi6zstVYVoOZ2CE/+VPzgYY6JinCbZP0r04bIgd+/KB6PfIcwVl2Q?=
	=?us-ascii?Q?oKb4C8Di5WXD0RwjJ+C8lH/iU9p8n+MIAu5BhrqtXcR3bdOu3JWhSMqH37Nj?=
	=?us-ascii?Q?RDatOYMW4m2umzzcVeJRnEj5wqCp2wsAK+hUZNAUQLgX0GeFFmr4owcBXxmv?=
	=?us-ascii?Q?MDrDvJy8OyBs4QmmcxjsPI8L0DpF6rkas920AFiZAVWiEBE7XgfTn9OQYKQ?=
	=?us-ascii?Q?=3D=3D?=
X-Microsoft-Antispam-Message-Info: SCFaaGfzI+gFiB9AQjefVuYtMWXPvnrNuXpL6FPFG8eWd3goOfRTR76JnlgmJ1xmVlEJeMJN5gJw+z3kzDBzDTk5MB9iqFQWIkIlKgI+TOJ1PbIwmKcYDwXdF76TFEynkowI3O1cDpWvzPVJlM6wuUmuluoSS6OXIUoLkRRGzunwpk6YLZbAV3m1tkNcrlLeXEwy1Ogkk/9sZjPwNOdO7AXQRxp3CTFDjc3Nv2rG4q+9LGuJjJQ2YWVMkBNwD5m26DmLYMB5tVRIRBqb4x97ED/6q3+r8KPXAAapW2qbvZ+H0QmXW5mpz0sxx/GxHdm5Bb0Bck2vSoBPa2QNSxv02IqsdP9Ijr02sdKGJjetc+4=
X-Microsoft-Exchange-Diagnostics: 1; DB3PR0102MB3673;
	6:JFG/LU0j5HmDPh+AngtKUa41Ha0B2QYIeGTvsKn00dft9eaiz3GYLJ2zCgefTp0BsZ3TiXv2wV/a3ZzILoQcKsRyXNQ77fWHXMY92hiFm4UxY6xvMTTFIfsBbxvLJb+K34zqzPYQO4Nphiz9jYdBvu5c/sEXPOrZ8KAmJP589MbP3nbrG2CYaxYw9AR+WpjAxehRhM6JnISFhfmu+4B5y8oXtkqjTj2yRw6JrN4cPwb0k902YOBdlESl0/HonmfmXCjBGwOvnGrcZj2JqAqSRbXJA17W5GHbM8y73HeXbCecBmJCJSYCuIMVF2EFbDLwRKYCBoGiU9aIyhGQDkyFI10pHuhSqk6HOvlRm83u7w9xfuiTFeoUiEdPCh6lMNHtKLTxx/KyUBkE1Go1qwFYJj2cil3nPHG1Kcoxo89Me7rQee5fMeCjPBDAYZaEWfI390k4flbw7uhpKI6CNr99EQ==;
	5:B76rdyuGV8a8XZfKK5zUAu2jr+DB6sRTSCDjNPU/V61HtwEA+9biMOGzZDnkyABDrn5J6x38O6NyrOMNXhCQ+a50cbsdbQZi/R1jgljvQoZ5PFaRVQSTOwvj9IQhgmxn0yagDxtlJ2Xr7OOv4UpD9w305k2IjTSnGCBgUuX2dMQ=;
	7:n9bb8MkGwtcaWxI3p35EMTLwZbtivS3YybLmkiuZPYZRcv9vIKZt5n+IbN7o10Y1fvMUhqNMtxLwYtWVmYQBbOXonFieGmoJmLvdcy5Fg07AJzTguFPl3QfPODA5jKOfwUAJBFkZzs7/B61NJJ6kiiJdBOjJqkmFXYH98ufkXNc1YkHOuz5u8h1Tnz7TBkHVxrrmg1VkHKwEEDmWrE+4GJEXeQ+8n7yR8Oq7Jv4/XdWdmhAOYcofyp8ixRCaRQp5
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-OriginatorOrg: graphcore.ai
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2018 07:52:32.3557 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99612a94-26f9-40b4-58e0-08d60671e2ce
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 02150d85-5b54-47ec-a80d-98af327512f0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0102MB3673
Subject: [PATCH] toaster: Fix comparison in recipe template
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: Patches and discussion that advance bitbake development
	<bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 21 Aug 2018 00:26:48 -0000
Content-Type: text/plain

Use == instead of = when comparing task outcome to OUTCOME_FAILED.

Prior to this fix the recipe template would cause a TemplateSyntaxError
exception.
---
 lib/toaster/toastergui/templates/recipe.html | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/toaster/toastergui/templates/recipe.html b/lib/toaster/toastergui/templates/recipe.html
index bf2cd71..3f76e65 100644
--- a/lib/toaster/toastergui/templates/recipe.html
+++ b/lib/toaster/toastergui/templates/recipe.html
@@ -176,7 +176,7 @@
                     <td>{{task.get_executed_display}}</td>
 
                     <td>{{task.get_outcome_display}} 
-                        {% if task.outcome = task.OUTCOME_FAILED %}
+                        {% if task.outcome == task.OUTCOME_FAILED %}
                             <a href="{% url 'build_artifact' build.pk "tasklogfile" task.pk %}">
                                 <span class="glyphicon glyphicon-download-alt
                                     get-help" title="Download task log
-- 
2.7.4


