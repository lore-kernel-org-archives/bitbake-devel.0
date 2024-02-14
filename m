Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CB8C48BC3
	for <webhook@archiver.kernel.org>; Wed, 14 Feb 2024 16:59:33 +0000 (UTC)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (NAM11-BN8-obe.outbound.protection.outlook.com [40.107.236.40])
 by mx.groups.io with SMTP id smtpd.web11.46668.1707929970328335584
 for <bitbake-devel@lists.openembedded.org>;
 Wed, 14 Feb 2024 08:59:30 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=iSj7tQeX;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.236.40, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bz2vN2UFruX5fS3vKD2FIf8w5sbrVq7xFiiN3qZpBlbkLxvHPc7kC4FnViViBClY4TZvpC1FHacPAcJav/IAtSQTAF2kITYtPbfe572pzW1g0jMVEo6uSgupzS+k2cg5n7GRqJwP8zIA3TZsbMGy+077cjKkVhWEJYhRkNoChpnVJfEMARLlu3jjtP3bDn922bRgerD8wE7q54xa+6Xkdfs5Y43+JgYUMCQk6uQYV4W9oZfdaATwozSAbtN5G3dqiPPjskERMUTVvCoLMq/fHkb66uyMHiUMVyhD1Avs9ytr3Py39vw8nkwtL5z6++QQrnN8Pqv3sFJN727x5Y8j3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCLxa5gAboSUDIzIaTi1KTGGV4LcXHH6Y91OKgxZbMc=;
 b=TZt6QKyU8r6EHwHldqtk+++cc4BOKtxksEyN1y8JnUArPsbbdaX/PoCJp7J1eV7PdEPvfet2ecBWiVtzm+1+k+iE/R4x+PJsZMso+UCCYiTkTU71cMhru0Mfth/4eZEw5PcmA0f2E6UeIXL7pEU9SCgTbtrAr6egEyZCY9gPy4GyO778tZBxvUO5l4IpctNVUNLfWp1rSFKNdH1unwOhR2XyeDuRUbVTR3g38g6wBKc5nWoZ+bJq00HTMAT6LYntal7KPItiwrnfLJ+NlGdAJLuZiDD63obWA8T8pkLCF/AZh7p/iIsO5EXAAedmhIRIoNkvyHd4LbmD37mJdRC4WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCLxa5gAboSUDIzIaTi1KTGGV4LcXHH6Y91OKgxZbMc=;
 b=iSj7tQeX7OPbemeOs4x92fBfD2rVJOqRSu03xfevgKkSF88RpDE4aqVVm8489sgVV7Z2wt8t35XazBH+wpW4/4B3lBRc0v2JiboygsF6IAPXq3jaz8OTl/CAykklZxOFFXzQWJKzCwPXb23VfkHwi91vy5qzFPq4Qmq/Edhpb+vCtdJZia8xLe1hfY4qn7m57Z1Sggjo9AA27y3Z0blNv6OaTjyMesyIWYp3tPZAFoFHZhx/6bqQefHgvbsoI+CFTG8lplzeoFDRXPhX9ZLLaEWITCwq1vRBcJabaX0UAv5tq9n1iKp8uF5/C3jviZM60kpUkZ6vr62sCYhJ9m4c+g==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 LV2PR12MB5871.namprd12.prod.outlook.com (2603:10b6:408:174::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.26; Wed, 14 Feb
 2024 16:59:26 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::a0e9:1e42:58af:ba95%6]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 16:59:26 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
CC: "behanw@converseincode.com" <behanw@converseincode.com>
Subject: Online tool for playing with variable expansion - first steps and
 where to host it
Thread-Topic: Online tool for playing with variable expansion - first steps
 and where to host it
Thread-Index: AdpfZydm5aBLa/+zQN6kD8lbigwWlg==
Date: Wed, 14 Feb 2024 16:59:26 +0000
Message-ID: 
 <DM8PR12MB54305F122A263BB3B7AD10B68B4E2@DM8PR12MB5430.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=4db4dfb6-63b2-424a-a5eb-d0aa35bc4a87;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2024-02-14T16:13:25Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|LV2PR12MB5871:EE_
x-ms-office365-filtering-correlation-id: 669c365d-c085-415d-7507-08dc2d7e4d78
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 o8ZDPnx/6EuJ2scmy4zuMnRjJC5JZdcHj8f7Jc9JbMgqpJhcUFNsZj8QRq9zCgoHVtQZYVMxKK2y6rFO6u6c3M9P+YZ8fA7mYLNFk5jcZlZkkH/uapS7la3/dpUyL+Bf6zf2jfANd3SX73ehwHwR+oICvevSa1MUW5K5x8Ete2DijiiPh2xcQnuAk2bOzzk6pFIS3TEnb5gBxeDlUz0C604NvN1pVy5Zk6uQjml/5J8k1yu9n9JPuh68Pl1vjkIXtF1P6E2nEXsf4aNIkiW7LLh8UuLzrphDcG1ZPdVuM9TGaCm4H+8qhYdh7gjdjz+UZQiu7RjwM5P+yJrMkRdsSi34/nlPcKHUbT3zm+wUBtxOCEUxwKJRXW96jpz9jQRqFJhsCUm+Y25NplIbdNkzXw+yswJRqG4WCwvsYDcAD1htC+q6y7xZeNsGPiCtTnvvV8HmvsOrIqP3n61J24JRzqhQGudb+EhCSDLs2Qu9XhIH8YU1IMyBRhzh1Q94HXCLTvD7kxUlEbgZV9NvrlNCidF+RlAT67+ocS0lTb5JeQV8IMMCr4/WMaQ5uTXmuKfyd3oieKG6+ND7TcTtUCMnTIPGoz0zLGdGIxSoV5NdsEY=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(396003)(39860400002)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(55016003)(316002)(71200400001)(5660300002)(2906002)(21615005)(66476007)(66946007)(76116006)(64756008)(52536014)(86362001)(6506007)(966005)(8676002)(4326008)(6916009)(8936002)(9686003)(7696005)(66556008)(26005)(38070700009)(478600001)(45080400002)(41300700001)(66574015)(83380400001)(122000001)(66446008)(38100700002)(166002)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?CqMPI79qL+fI64Zyt/749h8aZ9Nul4GeyegLjdGgVfV0DBFA1DNUPISsgEcV?=
 =?us-ascii?Q?cr0wYwpZJbLOt+6mljvRGtI4lZuBGnXoleO9OOMuuXHg1MVm+n+zrz7oB8FQ?=
 =?us-ascii?Q?EEvuzyw74xcl6OO0z3bmH7FIrAgUQEtq7m/288Ib/DzsatbRjOXJCK5+ANjt?=
 =?us-ascii?Q?GNXua3CTX11rgZ9lvaG/UWMy30KdoeTtpwCGq/9jIBQgTmaY8Bnag6+fShQ7?=
 =?us-ascii?Q?6akwsm0WvnOr1sRdYcogNgzZrjczCf4Sqia3S3ZqIEb0nZ4O+quIdnSo0J+Z?=
 =?us-ascii?Q?RhHoDxkhXH9/xw1yy8onZGRRiCNC0Sqr8yad0JCNS9X7saZIjquLhIoJ/V6G?=
 =?us-ascii?Q?GJJz4uh7jJgQBKCmwbQcynPj50yRoOx44Ore82V3Pxy0evPglRW374YY8NRY?=
 =?us-ascii?Q?yCIfO1RlO3FZ4oq1A3aLTw5ytGR2hoDqW2zAvHFVvM6e3vOac1Tsl+VOCxi9?=
 =?us-ascii?Q?90KgH13+26rCTgrNPVYgyXTY1arF8qAx12EesTZDTZVNuj4cS4MWs9C55Ya8?=
 =?us-ascii?Q?/gxDgPUWGN6CHFXc0qssC0K314Y8gp0JRD4qQgCL5ZL9lAPqpOg9sLyTHe2F?=
 =?us-ascii?Q?Zjbrlp2aT0R9EBhzb3pPe+CGvZT6WvVDP6qFyF7/xc9f+Ur8BrgDH1sscUrU?=
 =?us-ascii?Q?/9WSAj1jUK7Msu12rrZ+D3MyNJ1D57FXOsdTWel1zv05+E1qCrL4VrgT7N+1?=
 =?us-ascii?Q?YUZoirLmdOB19/vqeXMTZWlwuXAiTwt86Bnl3IP6XmFpqLirLn8qgqhDnlRg?=
 =?us-ascii?Q?SUKGAd1btGd6GkKq6WKG1Klivh8XYgw73UzZcF9czdUQULzaTlp2s33ViNkO?=
 =?us-ascii?Q?tnleWrHYRDXdx1U0TXFacWhOOIu4qaN+oUKSVJCP8J1Y8wQ6IiJ19brXA9eY?=
 =?us-ascii?Q?1fygou0P2lwBGwUEtojxvzc2slTxGkhk1he1c8nMrLE+/GrkBM6NQD1ElUnx?=
 =?us-ascii?Q?lrpFFE5HVmcgkVOHZZTRkOSYTdwqTsbLFaSea6Xbloyc6yzgz92fP4rYVOWb?=
 =?us-ascii?Q?a9cW+XFn3l49hXrtl0/EwkgnVWm+dxWJAxcggynmDDSVgnBubLLD2r1oEDM3?=
 =?us-ascii?Q?n2TNUziYnTlZ+FsWNZCRDQwptbYm49da8JYcDEQhRbCjFTjBKUN9hLpRHrik?=
 =?us-ascii?Q?4eZFegD+ciQAEFx6i0oVRNjt0zDUOw+0ZSwT8GXp/9L7CZAk7rEa1NhPCHzT?=
 =?us-ascii?Q?+1bzy48Enxf+/AdtItVMUdJESOjT/kcuMrdeAToJ/2kWPnshDJ4yVdCvexkl?=
 =?us-ascii?Q?rfHLB07wwmVb5oWZ7XxgEawdqt5rPfb7zknz0yAFmUUVmYs2IN7xCaSqMVVa?=
 =?us-ascii?Q?9dwtE2atsYxTxNDh3tbK8qYu05hVBG08acvhr7RiPLP1+cWNpRVMDV1piEfr?=
 =?us-ascii?Q?yNX203yAhaEaxoBrMdEedDPdbg6tO7A9fIeoVSVymXWf9Rqhb2EWQyePfA+Z?=
 =?us-ascii?Q?HmDYofu+Oyc1aqyoRKBiW3pnbgCoYnKZAN7nxR7nTUvVX689stC4ypwO3HX/?=
 =?us-ascii?Q?2MZpfvsSKZtdsg5IurjfNpdhe1QOiF1Ot5/fJrk93C8yzdHZdj3XAmvplkx+?=
 =?us-ascii?Q?rG4OCKIFtTV1tClleUjA6a/E3TsIAQLLeDx6jIVT?=
Content-Type: multipart/alternative;
	boundary="_000_DM8PR12MB54305F122A263BB3B7AD10B68B4E2DM8PR12MB5430namp_"
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 669c365d-c085-415d-7507-08dc2d7e4d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2024 16:59:26.8418
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G6T9EcS92ZyeVQO+Xt6s6sSW1oRz5w79vX1vTJUCCAY2utdnhAIqaoSnai/oXFnu2pk3xomcWhZbtmf46n6wTKldtUGwaEa2G90xsP0DM8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5871
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Wed, 14 Feb 2024 16:59:33 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15894

--_000_DM8PR12MB54305F122A263BB3B7AD10B68B4E2DM8PR12MB5430namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi all,

This bug ("A web based playground for experimenting with bitbake variable e=
xpansion") has been preying on my mind ever since I read it on Bugzilla: ht=
tps://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805.

I'm happy to say that I have a simple proof-of-concept implementation built=
 using Pyodide. The code needs some cleanup before I feel comfortable shari=
ng it, but here are some details:


  1.  Consumes an unmodified version of BitBake source code (currently 2.0.=
16).
  2.  Plays some games with the Python import system (https://docs.python.o=
rg/3/reference/import.html) to shim out certain modules (currently just fcn=
tl) that BitBake imports but Pyodide doesn't provide. (*1)
  3.  Executes the following test using JavaScript (*2):

        pyodide.runPython(`
            from bb.data_smart import DataSmart
        `)

        let DataSmart =3D pyodide.globals.get('DataSmart');
        const d =3D DataSmart();

        d.setVar("A", "B");
        d.setVar("A:test", "C");
        d.setVar("OVERRIDES", "test");

        console.log(d.getVar("A"));

        DataSmart.destroy();


As far as next steps, I was thinking I would build a simple-ish web app usi=
ng https://github.com/microsoft/monaco-editor (the editor that powers VS Co=
de). This would let us implement a Rust Playground-type of experience.

The two main questions in my mind are where to keep the code and where to h=
ost it?

For the code, I lean towards a separate repository. I was just going to put=
 it under my company's GitHub: https://github.com/Agilent. This is what I'l=
l do unless people feel strongly otherwise. (I'd rather not put it in BitBa=
ke itself since due to CORS restrictions I'll probably need to keep tar.gz =
copies of BitBake in the repo so the client can fetch it (*3). I also don't=
 think we want all the webpack and TypeScript clutter in BitBake)

For hosting, assuming it goes on our GitHub, I was just going to use GitHub=
 pages. The first iteration will be a client-side only application (*4)(*5)=
, so no server will be required except a static endpoint for serving BitBak=
e source code as mentioned above.

Does anyone have strong objections to this plan?

Notes:
    (*1) Interestingly Pyodide already provides sqlite3: https://til.simonw=
illison.net/python/sqlite-in-pyodide
    (*2) Exposing DataSmart to JavaScript is not necessarily relevant for t=
he online tool; I just thought it was cool. The actual tool will probably j=
ust call `pyodide.runPython` with the user-supplied Python code.
    (*3) I foresee bundling a couple of copies of BitBake - at the very lea=
st, one with the old overrides syntax and a modern copy. That way people ca=
n play with both.
    (*4) In the future, I can envision a server-side component for shimming=
 things like AUTOREV so that we can get git revisions; maybe also tie in ht=
tps://github.com/petersalomonsen/wasm-git.
(*5) If we wanted to get really crazy, could also potentially leverage http=
s://github.com/binji/wasm-clang - 'bitbake -c compile' in browser, anyone?

Thanks,
Chris


--_000_DM8PR12MB54305F122A263BB3B7AD10B68B4E2DM8PR12MB5430namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 15 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:#0563C1;
	text-decoration:underline;}
p.MsoListParagraph, li.MsoListParagraph, div.MsoListParagraph
	{mso-style-priority:34;
	margin-top:0in;
	margin-right:0in;
	margin-bottom:0in;
	margin-left:.5in;
	font-size:11.0pt;
	font-family:"Calibri",sans-serif;
	mso-ligatures:standardcontextual;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Calibri",sans-serif;
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-family:"Calibri",sans-serif;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
/* List Definitions */
@list l0
	{mso-list-id:241990537;
	mso-list-type:hybrid;
	mso-list-template-ids:-482677112 -1718191556 67698713 67698715 67698703 67=
698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"\(%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:27.75pt;
	text-indent:-.25in;}
@list l0:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:63.75pt;
	text-indent:-.25in;}
@list l0:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:99.75pt;
	text-indent:-9.0pt;}
@list l0:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:135.75pt;
	text-indent:-.25in;}
@list l0:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:171.75pt;
	text-indent:-.25in;}
@list l0:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:207.75pt;
	text-indent:-9.0pt;}
@list l0:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:243.75pt;
	text-indent:-.25in;}
@list l0:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	margin-left:279.75pt;
	text-indent:-.25in;}
@list l0:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	margin-left:315.75pt;
	text-indent:-9.0pt;}
@list l1
	{mso-list-id:511995251;
	mso-list-type:hybrid;
	mso-list-template-ids:398879270 67698703 67698713 67698715 67698703 676987=
13 67698715 67698703 67698713 67698715;}
@list l1:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l1:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l1:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2
	{mso-list-id:851606088;
	mso-list-type:hybrid;
	mso-list-template-ids:505337814 -115286062 67698713 67698715 67698703 6769=
8713 67698715 67698703 67698713 67698715;}
@list l2:level1
	{mso-level-text:"\(%1\)";
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l2:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l2:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3
	{mso-list-id:950363076;
	mso-list-type:hybrid;
	mso-list-template-ids:803354240 67698703 67698713 67698715 67698703 676987=
13 67698715 67698703 67698713 67698715;}
@list l3:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l3:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l3:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l4
	{mso-list-id:1075125342;
	mso-list-type:hybrid;
	mso-list-template-ids:-982758394 67698703 67698713 67698715 67698703 67698=
713 67698715 67698703 67698713 67698715;}
@list l4:level1
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level2
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level3
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l4:level4
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level5
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level6
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
@list l4:level7
	{mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level8
	{mso-level-number-format:alpha-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:left;
	text-indent:-.25in;}
@list l4:level9
	{mso-level-number-format:roman-lower;
	mso-level-tab-stop:none;
	mso-level-number-position:right;
	text-indent:-9.0pt;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"#0563C1" vlink=3D"#954F72" style=3D"word-wrap:=
break-word">
<div class=3D"WordSection1">
<p class=3D"MsoNormal">Hi all,<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">This bug (&#8220;A web based playground for experime=
nting with bitbake variable expansion&#8221;) has been preying on my mind e=
ver since I read it on Bugzilla:
<a href=3D"https://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805">https=
://bugzilla.yoctoproject.org/show_bug.cgi?id=3D14805</a>.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">I&#8217;m happy to say that I have a simple proof-of=
-concept implementation built using Pyodide. The code needs some cleanup be=
fore I feel comfortable sharing it, but here are some details:<o:p></o:p></=
p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<ol style=3D"margin-top:0in" start=3D"1" type=3D"1">
<li class=3D"MsoListParagraph" style=3D"margin-left:0in;mso-list:l1 level1 =
lfo1">Consumes an unmodified version of BitBake source code (currently 2.0.=
16).<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-left:0in=
;mso-list:l1 level1 lfo1">Plays some games with the Python import system (<=
a href=3D"https://docs.python.org/3/reference/import.html">https://docs.pyt=
hon.org/3/reference/import.html</a>) to shim out certain modules
 (currently just fcntl) that BitBake imports but Pyodide doesn&#8217;t prov=
ide. (*1)<o:p></o:p></li><li class=3D"MsoListParagraph" style=3D"margin-lef=
t:0in;mso-list:l1 level1 lfo1">Executes the following test using JavaScript=
 (*2):<o:p></o:p></li></ol>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; pyodide.r=
unPython(`<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; from bb.data_smart import DataSmart<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; `)<o:p></=
o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; let DataS=
mart =3D pyodide.globals.get('DataSmart');<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; const d =
=3D DataSmart();<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d.setVar(=
&quot;A&quot;, &quot;B&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d.setVar(=
&quot;A:test&quot;, &quot;C&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; d.setVar(=
&quot;OVERRIDES&quot;, &quot;test&quot;);<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; console.l=
og(d.getVar(&quot;A&quot;));<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; DataSmart=
.destroy();<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">As far as next steps, I was thinking I would build a=
 simple-ish web app using
<a href=3D"https://github.com/microsoft/monaco-editor">https://github.com/m=
icrosoft/monaco-editor</a> (the editor that powers VS Code). This would let=
 us implement a Rust Playground-type of experience.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">The two main questions in my mind are where to keep =
the code and where to host it?
<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For the code, I lean towards a separate repository. =
I was just going to put it under my company&#8217;s GitHub:
<a href=3D"https://github.com/Agilent">https://github.com/Agilent</a>. This=
 is what I&#8217;ll do unless people feel strongly otherwise. (I&#8217;d ra=
ther not put it in BitBake itself since due to CORS restrictions I&#8217;ll=
 probably need to keep tar.gz copies of BitBake in the
 repo so the client can fetch it (*3). I also don&#8217;t think we want all=
 the webpack and TypeScript clutter in BitBake)<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">For hosting, assuming it goes on our GitHub, I was j=
ust going to use GitHub pages. The first iteration will be a client-side on=
ly application (*4)(*5), so no server will be required except a static endp=
oint for serving BitBake source code
 as mentioned above.<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Does anyone have strong objections to this plan?<o:p=
></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Notes:<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; (*1) Interestingly Pyodide alread=
y provides sqlite3: <a href=3D"https://til.simonwillison.net/python/sqlite-=
in-pyodide">
https://til.simonwillison.net/python/sqlite-in-pyodide</a><o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; (*2) Exposing DataSmart to JavaSc=
ript is not necessarily relevant for the online tool; I just thought it was=
 cool. The actual tool will probably just call `pyodide.runPython` with the=
 user-supplied Python code.<o:p></o:p></p>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; (*3) I foresee bundling a couple =
of copies of BitBake &#8211; at the very least, one with the old overrides =
syntax and a modern copy. That way people can play with both.<o:p></o:p></p=
>
<p class=3D"MsoNormal">&nbsp;&nbsp;&nbsp; (*4) In the future, I can envisio=
n a server-side component for shimming things like AUTOREV so that we can g=
et git revisions; maybe also tie in
<a href=3D"https://github.com/petersalomonsen/wasm-git">https://github.com/=
petersalomonsen/wasm-git</a>.<o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"margin-left:9.75pt">(*5) If we wanted to ge=
t really crazy, could also potentially leverage
<a href=3D"https://github.com/binji/wasm-clang">https://github.com/binji/wa=
sm-clang</a> &#8211; &#8216;bitbake -c compile&#8217; in browser, anyone?<o=
:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks,<o:p></o:p></p>
<p class=3D"MsoNormal">Chris<o:p></o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
</div>
</body>
</html>

--_000_DM8PR12MB54305F122A263BB3B7AD10B68B4E2DM8PR12MB5430namp_--

