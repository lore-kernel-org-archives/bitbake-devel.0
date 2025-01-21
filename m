Return-Path: <chris.laplante@agilent.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13D11C02182
	for <webhook@archiver.kernel.org>; Tue, 21 Jan 2025 15:59:54 +0000 (UTC)
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (NAM04-BN8-obe.outbound.protection.outlook.com [40.107.100.61])
 by mx.groups.io with SMTP id smtpd.web10.19352.1737475192029704992
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 21 Jan 2025 07:59:52 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@agilent.com header.s=selector1 header.b=C6+QVQPU;
 spf=permerror, err=parse error for token &{10 18 %{i}._ip.%{h}._ehlo.%{d}._spf.vali.email}: invalid domain name (domain: agilent.com, ip: 40.107.100.61, mailfrom: chris.laplante@agilent.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wXU4OtGQnCR5mJjwcyo4Gursw28hXpFZ1qkMz2kWSnOKyDCS2ucdJhm32+VX9z5T0sqWMaLuiSVZSrhQWbMsHW/9XQaf+Jzy+75vcKn+OzKiuylIaC2tzYibsXbZhMLiB+oB8PZ/5P/1AAebDQvT6HfcIf5tYY8SRqiAmuS38NB6c8h6pq6ZfhxPbjLVlLMZtkCoF0dhKwPbFjiinIuER5MwgE6UHSmbhnZL9nfRCxyocKGGgqRTPVXZJXW2g1Z2pKZzwMqqPfOzSwmYYRh1cdfITffR9k/HF3uKwRy/2k+fWxvVADXFEv+SGuSDHvzFeCrLaPGB0W0s8F0B68pPFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86FPclyGW+vcyZmPvg4zAfQZVBaaWWklAhdF5FpUAJM=;
 b=sVgS38DbMBt0kq2NS2xlFAiWSgt2y4qCGKd6agiRbnJXKD6/XMZ4YzU1LKhTaJQ8b0uMhMzGFuBaCRk6HFbDcVwxB2cq4X8js74VXy0toQNy3csWCbBuu8KuYUBmcNKTufoqkJdkpLcbKpB8Om6JwHKG80wvkjhffAtWoxv93efciUwuyZ0718OK5TxHtqR3uBLxrPQ4lkDwXTltgbWCTk6Q5wHQPED811R+PJJ+fHO5+qvm3dsRGXCX0yEkoJ3XO8kbNtcqzPfS0JGQBL5lcVXE4USHMiEOZySvH1R7Upe6rNsV1YjxDBq9deU/jO1BYEdPg3Rt0i5tgWMmButAag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=agilent.com; dmarc=pass action=none header.from=agilent.com;
 dkim=pass header.d=agilent.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86FPclyGW+vcyZmPvg4zAfQZVBaaWWklAhdF5FpUAJM=;
 b=C6+QVQPULpT1pmnl11jbh2smlbTiRdir7N47kwvW09QhCz25tuC77Jy2uf/M0nKEpVsmCgOutYed3PZW5TlKDWlETdkrE46r4iu7s6umU7ipXiuSiE0xXs/sbjW7P0r0k0bAEjJjjeAqBvWq82iiWzCQFBaqjWCZsSESLI7OChTsKeOaM+Vd7O5S+pmKwIo8ynEQO3+PPPKSoD9cjvv6DnXp0QdmZ/5O/rBzZGH72X0LPKzdxxaQRc0vTnZhlnsY7TaLcsKfbfuZgaGUb9lQQig7TQSqW78y2hbSWPfk4VQzK7aGZTbKcYYVqbRsOZCaVGUwHQIXnE1kL9F8ziYuEg==
Received: from DM8PR12MB5430.namprd12.prod.outlook.com (2603:10b6:8:28::6) by
 LV3PR12MB9214.namprd12.prod.outlook.com (2603:10b6:408:1a4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.21; Tue, 21 Jan
 2025 15:59:45 +0000
Received: from DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7]) by DM8PR12MB5430.namprd12.prod.outlook.com
 ([fe80::604e:bc05:9357:c7d7%4]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 15:59:44 +0000
From: "chris.laplante@agilent.com" <chris.laplante@agilent.com>
To: "chris.laplante@agilent.com" <chris.laplante@agilent.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "steve@sakoman.com" <steve@sakoman.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
Subject: RE: [bitbake-devel] [scarthgap][2.8][PATCH 1/3] ui/knotty: print log
 paths for failed tasks in summary
Thread-Topic: [bitbake-devel] [scarthgap][2.8][PATCH 1/3] ui/knotty: print log
 paths for failed tasks in summary
Thread-Index: AQHbYU8GMSH+Mp82j0Wjh/C0kYSAuLMhd/Ag
Date: Tue, 21 Jan 2025 15:59:44 +0000
Message-ID: 
 <DM8PR12MB543073B6438DC6E0CA8AAFED8BE62@DM8PR12MB5430.namprd12.prod.outlook.com>
References: <181887D232995242.18084@lists.openembedded.org>
In-Reply-To: <181887D232995242.18084@lists.openembedded.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
 MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ActionId=f29676e9-4758-44ad-b2e2-33848575355b;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_ContentBits=0;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Enabled=true;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Method=Standard;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_Name=General;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SetDate=2025-01-21T15:58:14Z;MSIP_Label_8fcaca1c-04b8-40d7-944e-e72f4105afe1_SiteId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=agilent.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM8PR12MB5430:EE_|LV3PR12MB9214:EE_
x-ms-office365-filtering-correlation-id: 8cdea83b-9ca3-44ec-8d12-08dd3a349fb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: 
 BCL:0;ARA:13230040|1800799024|376014|366016|7053199007|38070700018;
x-microsoft-antispam-message-info: 
 =?us-ascii?Q?6oT9Iouj6oK5LpRN72W/3viwgGg61KOeYgmb+NI/FZa4DiXM7ibTbbqLcQCq?=
 =?us-ascii?Q?Mc4GNrS7RuHONB2NoAg4wm7Y0ajWKEA6nmCfkexWHw5ijF1i+A54DzwR8Jvj?=
 =?us-ascii?Q?BCjLUes1qqDRmeguJT62IX1FAc+8t6avlC/Q9HYbU+/cI/lIzKxseG3IVDNw?=
 =?us-ascii?Q?b27zyTUIxnLfZhP/fiB6clws06VKntB5Btpm534Bh63uSEpg9TymxaHQ9ZxG?=
 =?us-ascii?Q?pmVOglaVs9kFo/agv5yAv05ALbGsEOlrlpK2M7TG7x3LBbs8lSqUGZ25axE2?=
 =?us-ascii?Q?lR5lyJ3A+TaOv0JbLx9D0MbmKlue6V2LpizF79uTrpQ8QLUPafWmKxpWe/z0?=
 =?us-ascii?Q?igLCSXDu8gSymusLZg2e67+QciTaIIlMgI3dgPs0ZN6v0zziiPp7MIYLYlup?=
 =?us-ascii?Q?WEAVu2WFlTYBCzSk2ilp4dgvpENhMdREMCyvIoHlyvnuKr+WAGeMYEbJ8vdM?=
 =?us-ascii?Q?GStXjb15XID9B5H3Xa6/BRtwc4FUMdfw4VJe6XjgqoRyGnmjB2J0T2XYcWQw?=
 =?us-ascii?Q?y9sogEgPZwp76RB7Y3NSiU7K2fltBnkAkevBC+CimNcLkKKFTgdaCkh8oycu?=
 =?us-ascii?Q?edlMXPdWHQjATmjRYSa0RiXs/s6rXmplNE6hSft7/oPASjMyBlO4jGEr5Lck?=
 =?us-ascii?Q?K5IZnOPqojG/96eDMBJ/6Wibk7cVWtZniNeLqg+RK5T+q0Tzhxlh/mZ4RAOj?=
 =?us-ascii?Q?K2qzGJ7XNMJBimxrueeCOvKhlIAKbTi60rZBtfflK/woZXjIFxrVC9VOOJxb?=
 =?us-ascii?Q?w4iZxZl2pPRuzm1PU0Ev3BOqGOExCZ5wYeoDJkVk8bJhrOku5Z6H8wh53S5m?=
 =?us-ascii?Q?o9y9v/M/4jEWXjqv2OtdV/LAR/dVhctQiO8Oc/hzQF1IKm8gcZ5beWx7RLCi?=
 =?us-ascii?Q?ibuz8V8x/wqW6iLI5k3Si4fnPA3ET6PPz8Ts/7WuKfoVWRzF7KVuV35/Gw0M?=
 =?us-ascii?Q?W2Rg/+ALJDlJfn8ziz5xWOl3yK4KAhDPW+QmTUci0B3nQhZCx3F+XTdoHUn9?=
 =?us-ascii?Q?gg6ECr57jlbCAQAOOn6BV81MJ1/HKxSoAVjJ++ElRG7rux2QlRgqp0w3GhJK?=
 =?us-ascii?Q?MzzDIDCDM8+4WXZkKxfztwyc4Y67dg6ZUBLxL464JDmgGtBBzXSnywfQi+uE?=
 =?us-ascii?Q?e2J4KSyR5mn35Cq3fawrgNZhlHqZidH+0QLwiJwbgEXJboh2xSHdVgluAagO?=
 =?us-ascii?Q?2oa1qVECfxVAM7FDfgOYfc062Y4uhK1u8QtRa3QwNsrwetT3LPq1PIZhgmht?=
 =?us-ascii?Q?nV+LZF3FZTbmKRazhnaybwWjNLJUXoFdAu1yQjh2eE7gva24mo0f4YrSRyIh?=
 =?us-ascii?Q?7MZthd8+V1KG/UV4i79++lgHa8xycZfb6f+yN01Ano+OhCWp7HcXxypGjJZL?=
 =?us-ascii?Q?ONKhPu47NXWwQmuKpa0qv6Mm/BQT?=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5430.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?us-ascii?Q?iOXGdFtEP7ykeXsk4HtC/4N079Qm1kCkOuq83gGw1grcY6e1N2avsB67k+Zg?=
 =?us-ascii?Q?Cnc72tbYlW0CvPDF6cxCl7XZ1Ww7LnvF1QdieQHIWgxqD3ywKO1kZKa05iqL?=
 =?us-ascii?Q?4bW7eU6v9qjkP6mY1gf1kuxEd4n3Pqr4lb7Ktdrle6B9qn+Spnyl06wUMvQB?=
 =?us-ascii?Q?RR9rAYwnh476ewIt99EwM4JQSwQzv0D7U4EjqSEjj08zscPnnEHEA9OAm1je?=
 =?us-ascii?Q?eZfTHlNmjB0sfj9fuwpIGpO7nfTaAehP599ki0qOQ+lGSlaJHkiiCefEJjQL?=
 =?us-ascii?Q?ib4pRPtE/jS9NQKW9InKT7EYVx1ygowdR/zQjsTkWDta8yG9EvwGpDzcAj/O?=
 =?us-ascii?Q?nOuLP27gJ8JZGzXBvPw+CVsT9cQ7Uv7jZJOKZmDObvl6/N3M095ioM3WPyZa?=
 =?us-ascii?Q?st28vqwe0UhIo/Q4asc1o/93UaS+voL74X+7+UO9AXMSStPiPkasyWL4rN89?=
 =?us-ascii?Q?YH39XJu/6FEODnfgSLpaFq+QYcA9x6ntzF5mtlRmVyV4rBf84t4kUuDlQeQm?=
 =?us-ascii?Q?2t8OWPg3s43xBdgUi6XtHoWOHAyxyW9LaQOKzV1/0ust4AOyssD0zxPIWprQ?=
 =?us-ascii?Q?tvM9XxbaPHoFv0j/i3BYwhlWVM6tp07ApiZg3rkFoZxcoihO+Bp9TCl8RYFj?=
 =?us-ascii?Q?Kd8ysLc17V7xckVTtOHtickPZcsZ2gXxJ3sl1XTsVnIxqqnoV+7UEhh7z8Bq?=
 =?us-ascii?Q?89vBHeGYkjNaLz0Ji4O/N0UIrHQkp2DzkOVRJJBjOnyDcwGQEo75gh63hXL2?=
 =?us-ascii?Q?XoOGZY2Uf8qZr82/8kbhCfyjvY8EfoES1zIh8uzQXGeCyy2fJbQx477NwkTD?=
 =?us-ascii?Q?GOiP886zy8K6L4qejbOz1kl5KDx6MuRWkRzlaH8alLBHFtcOv3sYs9GfrXKr?=
 =?us-ascii?Q?yWe3RHLh2mNAo5JYgFKa9JJaWpJM64IHQ2guvMoIzBqPzLbe7qj59Fjg1UuP?=
 =?us-ascii?Q?pvAkT5qepTqp7+C1Gcz2GZzRZaz9AeKK5QEv+eOWXr+cm9gKLNvw2xAwsHhb?=
 =?us-ascii?Q?77qYNNWzjMNmJuPOr/qSb6h22FZ13i1JUddtxDHFCtwB7KKGQHKtCTxLKG/Y?=
 =?us-ascii?Q?Fg9JrYhJ2qbkwpZG/daWF/aCq1WJD9iORj6TWk0pS2Ai4JgvzBUEm5xg1iEO?=
 =?us-ascii?Q?YTlNDstVrln4SbmZf6LMqNHhmqbS5YQWRjRDArZdmhJRhS6pCacN7pw2ghZ4?=
 =?us-ascii?Q?y0Ad0wnl2Ec9ARId/v8lO9sNinM01h4HPDCtafXG4kh7c6H6pY4MO61aIk2f?=
 =?us-ascii?Q?9fKQnHvci5Mffw14n40kvjHvwoumaQV41tsBQtR2XN/MQf7MHeXrnjyNNn3b?=
 =?us-ascii?Q?KdegLhk1kxbWAkzjCL0dv/clZyICksuuzpJ9iGGDKGgGd5sr0T45m+ay+g5z?=
 =?us-ascii?Q?pBkEjXdewKS2U7u3ZrY/q3HK2JrJf54CtyCw/TMqqnAGsJk+4vT17qM8Pyor?=
 =?us-ascii?Q?C4G9QlwtsnfIhrOoryOyTMFHHgGSWF0g3n9xisOhuvmwSqdBi6/qrQRQDPYZ?=
 =?us-ascii?Q?6Sy18dMffiOqkYfokknw2+5mZnQnkyZf88asJDew6nbIfzsEx0Z5S4ufvLL7?=
 =?us-ascii?Q?49mFGEwm7J9BUx9vBgf2NYfSr42FvKoA8d6Kshk/?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5430.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cdea83b-9ca3-44ec-8d12-08dd3a349fb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 15:59:44.8265
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XkIiGgGqINpZY0aA7Fvw+Ahyygtet+7zsaEU+GxjOwoMwZjUqUASXLXZ3hZZOT9sqxI9qt5IE72G4WtxoC2SYOk7wSqALSJcdDQvOrU8IoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9214
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 21 Jan 2025 15:59:54 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/17040

Hi Steve,

Just wanted to check to see if you saw my backports to Scarthgap from a few=
 weeks ago. It's definitely possible I did them incorrectly.

Thanks,
Chris

> -----Original Message-----
> From: bitbake-devel@lists.openembedded.org <bitbake-
> devel@lists.openembedded.org> On Behalf Of Chris Laplante via
> lists.openembedded.org
> Sent: Tuesday, January 7, 2025 4:54 PM
> To: bitbake-devel@lists.openembedded.org
> Cc: steve@sakoman.com; LAPLANTE,CHRIS (Agilent USA)
> <chris.laplante@agilent.com>; Richard Purdie
> <richard.purdie@linuxfoundation.org>
> Subject: [bitbake-devel] [scarthgap][2.8][PATCH 1/3] ui/knotty: print log=
 paths
> for failed tasks in summary
>
>
>
> External Sender - Use caution opening files, clicking links, or respondin=
g to
> requests.
>
>
> From: Chris Laplante <chris.laplante@agilent.com>
>
> When tasks fail, it's very frustrating to have to scroll up to find the l=
og path(s).
> Many of us have the muscle memory to navigate to the 'temp'
> directories under tmp/work/, but new users do not.
>
> This change enhances the final summary to include log paths (reported via
> bb.build.TaskFailed events). Here's an example:
>
> NOTE: Tasks Summary: Attempted 856 tasks of which 853 didn't need to be
> rerun and 3 failed.
>
> Summary: 3 tasks failed:
>   virtual:native:/home/chris/repos/poky/meta/recipes-
> core/ncurses/ncurses_6.5.bb:do_fetch
>     log: /home/chris/repos/poky/build/tmp/work/x86_64-linux/ncurses-
> native/6.5/temp/log.do_fetch.1253462
>   /home/chris/repos/poky/meta/recipes-
> core/ncurses/ncurses_6.5.bb:do_fetch
>     log: /home/chris/repos/poky/build/tmp/work/core2-64-poky-
> linux/ncurses/6.5/temp/log.do_fetch.1253466
>   virtual:nativesdk:/home/chris/repos/poky/meta/recipes-
> core/ncurses/ncurses_6.5.bb:do_fetch
>     log: /home/chris/repos/poky/build/tmp/work/x86_64-nativesdk-pokysdk-
> linux/nativesdk-ncurses/6.5/temp/log.do_fetch.1253467
> Summary: There were 3 WARNING messages.
> Summary: There were 6 ERROR messages, returning a non-zero exit code.
>
> Each log is rendered as a clickable hyperlink in the terminal. See
> https://gist.git/
> hub.com%2Fegmontkob%2Feb114294efbcd5adb1944c9f3cb5feda&data=3D05%
> 7C02%7Cchris.laplante%40agilent.com%7C5b537b9495ee47796cca08dd2f66
> 26a2%7Ca9c0bc098b46420693512ba12fb4a5c0%7C0%7C0%7C63871883797
> 6736782%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOi
> IwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0
> %7C%7C%7C&sdata=3DS%2BTUoiFdgIoeVg0J%2F7VWsV91R3Qa14Lcsvff8SjTDlc
> %3D&reserved=3D0
>
> Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
>  lib/bb/ui/knotty.py | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/lib/bb/ui/knotty.py b/lib/bb/ui/knotty.py index
> f86999bb0..5956ab177 100644
> --- a/lib/bb/ui/knotty.py
> +++ b/lib/bb/ui/knotty.py
> @@ -640,7 +640,7 @@ def main(server, eventHandler, params, tf =3D
> TerminalFilter):
>      return_value =3D 0
>      errors =3D 0
>      warnings =3D 0
> -    taskfailures =3D []
> +    taskfailures =3D {}
>
>      printintervaldelta =3D 10 * 60 # 10 minutes
>      printinterval =3D printintervaldelta
> @@ -726,6 +726,8 @@ def main(server, eventHandler, params, tf =3D
> TerminalFilter):
>              if isinstance(event, bb.build.TaskFailed):
>                  return_value =3D 1
>                  print_event_log(event, includelogs, loglines, termfilter=
)
> +                k =3D "{}:{}".format(event._fn, event._task)
> +                taskfailures[k] =3D event.logfile
>              if isinstance(event, bb.build.TaskBase):
>                  logger.info(event._message)
>                  continue
> @@ -821,7 +823,7 @@ def main(server, eventHandler, params, tf =3D
> TerminalFilter):
>
>              if isinstance(event, bb.runqueue.runQueueTaskFailed):
>                  return_value =3D 1
> -                taskfailures.append(event.taskstring)
> +                taskfailures.setdefault(event.taskstring)
>                  logger.error(str(event))
>                  continue
>
> @@ -942,11 +944,19 @@ def main(server, eventHandler, params, tf =3D
> TerminalFilter):
>      try:
>          termfilter.clearFooter()
>          summary =3D ""
> +        def print_hyperlink(url, link_text):
> +            start =3D f'\033]8;;{url}\033\\'
> +            end =3D '\033]8;;\033\\'
> +            return f'{start}{link_text}{end}'
> +
>          if taskfailures:
>              summary +=3D pluralise("\nSummary: %s task failed:",
>                                   "\nSummary: %s tasks failed:", len(task=
failures))
> -            for failure in taskfailures:
> +            for (failure, log_file) in taskfailures.items():
>                  summary +=3D "\n  %s" % failure
> +                if log_file:
> +                    hyperlink =3D print_hyperlink(f"file://{log_file}", =
log_file)
> +                    summary +=3D "\n    log: {}".format(hyperlink)
>          if warnings:
>              summary +=3D pluralise("\nSummary: There was %s WARNING mess=
age.",
>                                   "\nSummary: There were %s WARNING messa=
ges.",
> warnings)
> --
> 2.43.0


