Return-Path: <stefan.herbrechtsmeier-oss@weidmueller.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3617BE7718C
	for <webhook@archiver.kernel.org>; Fri, 20 Dec 2024 11:26:41 +0000 (UTC)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (EUR05-DB8-obe.outbound.protection.outlook.com [40.107.20.104])
 by mx.groups.io with SMTP id smtpd.web10.149981.1734693987801828257
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 20 Dec 2024 03:26:28 -0800
Authentication-Results: mx.groups.io;
 dkim=fail reason="dkim: body hash did not verify" header.i=@weidmueller.com header.s=selector2 header.b=7jawAoja;
 spf=pass (domain: weidmueller.com, ip: 40.107.20.104, mailfrom: stefan.herbrechtsmeier-oss@weidmueller.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF7GjS2OlckO5B8kiu49fuJdJ5iK81carWFHXdiGdPcksEuyHZbH6rFzZDIwdg49Nv8poAmmMMCaUClnyHybn5PGrGcUPTlgy0aRWPag1M/OzX8jgSGAllGV08bRg94AXBNlPy+Olm+kXm725hnv5HQEuIc5ODCBHy+s+CIS+3hbO4hVyCxBVzkWF7Axbp/ig1qAYV7NGggBdy68SLBj+M2k/5NGsWo3/2bjLHW9D6IJOl1p0lF/WiCPIL7XgHR0jYnU6Mq6lpFFthMkMdAF03UZC0TfRh/10jfJzpGA2biQm+Jz/AnI9PMVHdPqqEqysxPuUiTw0dWksLabZUHq0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y7rJVrOqMobu3b6Rc0bxsj1RphKyIHeDXoBMTd2Q95c=;
 b=htBif4+WoWYXFSFQpb+IXh5qWQDqQY6zBvn/QK7ib8KoVb8qb83SpQmuOFkthcmu2wqWO1Mze9cANj/3SNFgIyqoFKYuJTyiBaYfnH2C/hmcjc2TWFplTQcAMLTysCiLwLx4Ubfu3zo52z9cVpyNmng8IhsPMIZI3eAZsDaPMWR3gwpYgzVSw5DDsDGZJ0XjoKDKj8vT5SdSwC/OkFAOi1qaFOijK27hsLiBveuU3tj965YoQQeSdsICAMUXCTUqhkXHlJFJkpXqLKE6EZ0qvGieOCJ/JEjiNNXA6DU1BmdKiF6B/GVbJQk6aOHqUYoG1BR9ytIUEE3/gfvKIoBgoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=weidmueller.com; dmarc=pass action=none
 header.from=weidmueller.com; dkim=pass header.d=weidmueller.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=weidmueller.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y7rJVrOqMobu3b6Rc0bxsj1RphKyIHeDXoBMTd2Q95c=;
 b=7jawAojaUA07PrCp8UWOpXLZn5qZzLmEAoYbsbn41bCNDOamlDUvnSXTzB9w7CEindB9LiaX4eWl0ACSUSf49CZEqnaFbKLZnVwzTTJ14m6CJmsWiI4DOhyT4kqi/swDrbmQ6ETfAHMK23p5OtmLUWFJSn/OpbEVu5Y2I/jUB516RVHHRJvP1nQ4/ngDP4yGUcY7e2v1mwTVOs3pw6PcryV62PG0b2tnwGw9p8T6d4szmtsiCoFX3/yHmx81ONVLUaP3t9ZrvA8+MyRXVXVi+MDgtfKeXkEJlRYzFyLHD39XY/tB/2yMJW/oUUilB8XJZRIe0NFyQCF2YU5SilMYAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=weidmueller.com;
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com (2603:10a6:102:1d8::23)
 by DU0PR08MB8256.eurprd08.prod.outlook.com (2603:10a6:10:410::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.14; Fri, 20 Dec
 2024 11:26:24 +0000
Received: from PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4]) by PAXPR08MB6969.eurprd08.prod.outlook.com
 ([fe80::3b1:b329:1ed9:dad4%3]) with mapi id 15.20.8272.013; Fri, 20 Dec 2024
 11:26:24 +0000
From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier-oss@weidmueller.com>
To: bitbake-devel@lists.openembedded.org
CC: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>
Subject: [RFC PATCH 00/21] Concept for tightly coupled package manager (Node.js, Go, Rust)
Date: Fri, 20 Dec 2024 12:25:51 +0100
Message-ID: <20241220112613.22647-1-stefan.herbrechtsmeier-oss@weidmueller.com>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: FR0P281CA0106.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a8::7) To PAXPR08MB6969.eurprd08.prod.outlook.com
 (2603:10a6:102:1d8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR08MB6969:EE_|DU0PR08MB8256:EE_
X-MS-Office365-Filtering-Correlation-Id: 2393a1e7-1bb4-4b18-0ddd-08dd20e922d9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: 
	BCL:0;ARA:13230040|366016|52116014|1800799024|376014|38350700014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?6/qGQnJJgnVAv25EDp8Lc2+ms2SX+717WCdMM/wUHktBzdbwGVs+pTJDepKo?=
 =?us-ascii?Q?KUfZr4YiJJ7hQ7u4hIDB769hDCkbK4IOq1ll0CZc3L3PfBQWhtqjofdy0MYq?=
 =?us-ascii?Q?wO8J/6g0VVOZv2oeZQmQFpIXvPu+wgP3JmTB277PB22g5ei1ZOxZUGRj5gsl?=
 =?us-ascii?Q?Aqv7fQnyioWLtzNaJGKh1tHhcqZF7edkj57dTr6KLOFdUbAcOzvNslSVLGEs?=
 =?us-ascii?Q?Jeoo5c3DAem6gPYvLC3kh55TA2Wvwly8auxUQvaG0BTUID8N1KGpob1o1vgp?=
 =?us-ascii?Q?j9s3ReKQwxaijJHvWd5WBMvyP9IkiZO+iHzwGgwZUeNAzJFIQ/ZbvcXbSfBp?=
 =?us-ascii?Q?jjoQ3Na5eu3gTOtbyKwRPg0v8NPlnCxdeei/txOdy2KYYhCus4sacjt5jGPN?=
 =?us-ascii?Q?DEF3wPUQeFfI18B2Eu+YxZ8tPjuTug37laAo0n8a5SzFckocfbqkZvjznRQ9?=
 =?us-ascii?Q?33TXcEy22OP/9B6SjxJ1kay6KUa37bj2a48NTrMRNLAHvkxQ1yVJIpatL9Yq?=
 =?us-ascii?Q?1n30gE+x9tH3VdCt4nGJU8k8xScjvpFpxGYdPPPSWZPW92M+9pja4enGH/+w?=
 =?us-ascii?Q?0oOSqlHD3gJl8N11ZKhEbH5TjRZQyq1QgLUXqWGDA9lGag666lbv0HkpSKsz?=
 =?us-ascii?Q?y+5IUJMvavtRLVNc4DM5/jM4UFMhLOGykRLO+rA0Tef8zxwjP9upZhLUkx8p?=
 =?us-ascii?Q?1rgaYXXzwnHNQQxR26V/1c6cmkQDigvBD6LjMtdcdafQcgbKu5Khr49XMk2F?=
 =?us-ascii?Q?pDE19QsDJiN+Kwq68wbZVoDr28VLEhh4bmK+VElyCTgCYugEk4zoerRCXnCN?=
 =?us-ascii?Q?ukL+A7WhxUeTrocEjs3pjEiSifLRa7P6dozYpS1cZl2eW+BwgbksbNhT92KI?=
 =?us-ascii?Q?GL7ZC7DM+hBAHpLktcKpfj/qL7IPwJUneJ4/rDYGizIRCf8LlbG9JWLfQ70n?=
 =?us-ascii?Q?LzALsr3zf4EqU706pHTfFvwXm0cbYyFLpcwV4OG1oZLvjHDi+EMiawnZW55Y?=
 =?us-ascii?Q?mxUB1Ug6bIF+sO7//HobAQ0b/e3C7kSf2UXYKEeYwaNGI+kuj24YfNU8kb9o?=
 =?us-ascii?Q?LdMRgSFp5J3/jaPO9/8MlQl/hTtivT65PoRyk1Z6Tv3zgiu/Q2hSKrEf2Cid?=
 =?us-ascii?Q?jFUM4UWeFLg67BtFbvI2D3WeYrniAK87F9H4+ma+2H6cS8DyDuPP0Prk5Kyf?=
 =?us-ascii?Q?KB2Ccmq0pR9JG881NuIyYXMHuS/OAAcC9Un6vRv5WtQqtGWPdoZqaZNjQRwb?=
 =?us-ascii?Q?ItQuxqgWUQhzWp9Ok/TrxDeUnLn1+VnOl/pF8x/ICrVBZS73mc4Z4OFcJ+E7?=
 =?us-ascii?Q?ojN0VVQRZgxeNBvH63/zS4vu48LXgjXH4E9UzbClsA7WqMT12GFYrkIk8OY0?=
 =?us-ascii?Q?8h5yUlBEiHBdV8O1RY32ISBtvZhT?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR08MB6969.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(1800799024)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?9iXLHGdriBkxpljmsMGEo9HXDTQtr1gQ5ycY8qwsVlN+zdFeYv6C1yD/E6CL?=
 =?us-ascii?Q?YSxOrD3LBV+CP+PDPlBIOZJQVEroQv9eGM130h4aSjCLtR07KQMLsC+ZA3+r?=
 =?us-ascii?Q?Lyah1OemPMkmH8bGLL1XgmlThB/rJXGk/JR+Ez1vnwL1WZ5f3VNXvHZoOyeJ?=
 =?us-ascii?Q?G+XktFo5UOrl4L1fxDII709PvOJqEOCgjMagkMMZa5pPEu9kZOLk4NZ2tYLO?=
 =?us-ascii?Q?DOF9QHylCnJ2G+xJ4Bk4t4VOGguPP9xz8jDL3Soi95Kf+K2PmIaH0SDKp2Y1?=
 =?us-ascii?Q?/dmIoUaI9Y9Bism2uUqmHZE8MagKQoXrPEKgv9atrmYNv1rr6lYhuzBkDJz1?=
 =?us-ascii?Q?FsHl9asKcSBgmh3ZM6uBo+AAM7UzOt/2fnm8g0KzFhRNEZtFjcug+EnXGV2m?=
 =?us-ascii?Q?8QhsYpDCiOPooo7Q9QWx1i/LIXhZCqcJS1M3sd7hCVhg6OXmxIr5ucNW/Gau?=
 =?us-ascii?Q?2Seo1IutygTLi/cjltiES1c86kDfWNQ/IoOj3GJD3SCgZQ2C1KY0HaUawr9f?=
 =?us-ascii?Q?urE/IoeTfdBCfgENjSiRSjutj/QGSgImMbb3MLMKPZk62l70kh3CnS6vO5I0?=
 =?us-ascii?Q?/Z6E9Kxij6OcqBM0BhqlwHd/CguN7V9FAqQPMm2wFWCD2cfNVSpuPq6YiHY7?=
 =?us-ascii?Q?94plA0ZkyItpAswFT2G2cP7Cl+tuDlTUEtaAW9ji2qJRhxwXDVOCFvykIWXX?=
 =?us-ascii?Q?SHMhfo1B6EYmtu1Pi+rxUiBAUwx8YYgux8Eeqdg6ArLyXtZyOnBflWsFFKaf?=
 =?us-ascii?Q?65AyXHo9a9wgO1LV80CxC2EDIrEXQlDVxbmp5w2bDAygpnfq00AZvO03lnrR?=
 =?us-ascii?Q?a2P1QhV7/1wBK4Zo1qo7z4TYnmSkPCC6x01ma4lB2gRRl2oE2pI7NPaXMcUc?=
 =?us-ascii?Q?a1HIvPa0OuZUbMrnolG31gnTQURy/MX2YD08pqksB9VXpXdD24Cd05Xv0SBR?=
 =?us-ascii?Q?7wO2fzOYirkoX9zNBSKTugxe/W+SMUvEgm2/bpo0OkEhd5ZSJ6IYnDmbwBgy?=
 =?us-ascii?Q?Vp0uixBFmecFX2ivZZZnVD6WSyh+isZ5orYMyqMI/vH6LPTh6xHWD1UCbYed?=
 =?us-ascii?Q?0xwc6uX69i8KHFexxIe7IRdEhkzDSqpPlBXAlglwBI4H1OMz3CuaPYP6e7Ex?=
 =?us-ascii?Q?CFn+lrzUvQPgqEsi9Eml5tC83xc7xg4GdXYTbC18CNyBv6Tmav47n8E4DATV?=
 =?us-ascii?Q?bxok81pvsfNP+RzkXeFi2EjersvBdxELhrUmDJLK2EIGmPKuo41XXq8FlKgz?=
 =?us-ascii?Q?1U3jLXQPR6k8zjtv/x95wzxPhwAVKG8JB6V22uw3ovPIJ/frXYKf45U/XB+k?=
 =?us-ascii?Q?tLLauHFYmf2wrJz9zH0/hKCE6ig/TPPCHryP//gJFhwGDw8tStev6wHiWdqT?=
 =?us-ascii?Q?bA3Dv2W2nr9ra1QdPxPnrfoS8DVD7WkMZq1/y59sLtjDpCVZ/oBSxSoXVMZJ?=
 =?us-ascii?Q?SJ5WW6Q5fozYVMSsvPh/dYVGExQrJEaEvao4tQfuvSPu9UCgOVEmv6xPt60x?=
 =?us-ascii?Q?AjkvW4ggPKEV1rEDS0nHn7EWjOGeV4oT9ms4hSHQKoGCUEsERW/QEJs3tL8X?=
 =?us-ascii?Q?ZNBENeeznfmtU0Hww6S01OKosvVCOa8tnlUQZ7S7rz75GjQKHxUeRerwF74c?=
 =?us-ascii?Q?Tg=3D=3D?=
X-OriginatorOrg: weidmueller.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2393a1e7-1bb4-4b18-0ddd-08dd20e922d9
X-MS-Exchange-CrossTenant-AuthSource: PAXPR08MB6969.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2024 11:26:24.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e4289438-1c5f-4c95-a51a-ee553b8b18ec
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qAxdxdfnXztjWFN3Mqn+FqyvT82FGfWm7Ux8/+XtUuCDjzilFfir3nITbtUgwR4y2u5t4fJTOVuRYEc3u5UJDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR08MB8256
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 20 Dec 2024 11:26:41 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/16920

From: Stefan Herbrechtsmeier <stefan.herbrechtsmeier@weidmueller.com>

The patch series improves the fetcher support for tightly coupled
package manager (npm, go and cargo). It adds support for embedded
dependency fetcher via a common dependency mixin. The patch series
reworks the npm-shrinkwrap.json (package-lock.json) support and adds a
fetcher for go.sum and cargo.lock files. The dependency mixin contains
two stages. The first stage locates a local specification file or
fetches an archive or git repository with a specification file. The
second stage resolves the dependency URLs from the specification file
and fetches the dependencies.

SRC_URI =3D "<type>://npm-shrinkwrap.json"
SRC_URI =3D "<type>+http://example.com/ npm-shrinkwrap.json"
SRC_URI =3D "<type>+http://example.com/${BP}.tar.gz;striplevel=3D1;subdir=
=3D${BP}"
SRC_URI =3D "<type>+git://example.com/${BPN}.git;protocol=3Dhttps"

Additionally, the patch series reworks the npm fetcher to work without a
npm binary and external package repository. It adds support for a common
dependency name and version schema to integrate the dependencies into
the SBOM.

=3D Background
Bitbake has diverse concepts and drawbacks for different tightly coupled
package manager. The Python support uses a recipe per dependency and
generates common fetcher URLs via a python function. The other languages
embed the dependencies inside the recipe. The Node.js support offers a
npmsw fetcher which uses a lock file beside the recipe to generates
multiple common fetcher URLs on the fly and thereby hides the real
download sources. This leads to a single source in the SBOM for example.
The Go support contains two parallel implementations. A vendor-based
solution with a common fetcher and a go-mod-based solution with a gomod
fetcher. The vendor-based solution includes the individual dependencies
into the SRC_URI of the recipe and uses a python function to generate
common fetcher URLs which additional information for the vendor task.The
gomod fetcher uses a proprietary gomod URL. It translates the URL into a
common URL and prepares meta data during unpack. The Rust support
includes the individual dependencies in the SRC_URI of the recipe and
uses proprietary crate URLs. The crate fetcher translates a proprietary
URL into a common fetcher URL and prepares meta data during unpack. The
recipetool does not support the crate and the gomod fetcher. This leads
to missing licenses of the dependencies in the recipe for example
librsvg.

The steps needed to fetch dependencies for Node.js, Go and Rust are
similar:
1. Extract the dependencies from a specification file (name, version,
   checksum and URL)
2. Generate proprietary fetcher URIs
  a. npm://registry.npmjs.org/;package=3Dglob;version=3D 10.3.15
  b. gomod://golang.org/x/net;version=3Dv0.9.0
     gomodgit://golang.org/x/net;version=3Dv0.9.0;repo=3Dgo.googlesource.co=
m/net
  c. crate://crates.io/glob/0.3.1
3. Generate wget or git fetcher URIs
  a. https://registry.npmjs.org/glob/-/glob-10.3.15.tgz;downloadfilename=3D=
=E2=80=A6
  b. https://proxy.golang.org/golang.org/x/net/@v/v0.9.0.zip;downloadfilena=
me=3D=E2=80=A6
     git://go.googlesource.com/net;protocol=3Dhttps; subdir=3D=E2=80=A6
  c. https://crates.io/api/v1/crates/glob/0.3.1/download;downloadfilename=
=3D=E2=80=A6
4. Unpack
5. Create meta files
  a. Update lockfile and create tar.gz archives
  b. Create go.mod file
     Create info, go.mod file and zip archives
  c. Create .cargo-checksum.json files

It looks like the recipetool is not widely used and therefore this patch
series integrates the dependency resolving into the fetcher. After an
agreement on a concept the fetcher could be extended. The fetcher could
download the license information per package and a new build task could
run the license cruncher from the recipetool.

=3D Open questions

* Where should we download dependencies?
** Should we use a folder per fetcher (ex. git and npm)?
** Should we use the main folder (ex. crate)?
** Should we translate the name into folder (ex. gomod)?
** Should we integrate the name into the filename (ex. git)?
* Where should we unpack the dependencies?
** Should we use a folder inside the parent folder (ex. node_modules)?
** Should we use a fixed folder inside unpackdir
   (ex. go/pkg/mod/cache/download and cargo_home/bitbake)?
* How should we treat archives for package manager caches?
** Should we unpack the archives to support patching (ex. npm)?
** Should we copy the packed archive to avoid unpacking and packaging
   (ex. gomod)?

This patch series depends on patch series
20241209103158.20833-1-stefan.herbrechtsmeier-oss@weidmueller.com
("[1/4] tests: fetch: adapt npmsw tests to fixed unpack behavior").


Stefan Herbrechtsmeier (21):
  tests: fetch: update npmsw tests to new lockfile format
  fetch2: npmsw: remove old lockfile format support
  tests: fetch: replace [url] with urls for npm
  fetch2: do not prefix embedded checksums
  fetch2: read checksum from SRC_URI flag for npm
  fetch2: introduce common package manager metadata
  fetch2: add unpack support for npm archives
  utils: add Go mod h1 checksum support
  fetch2: add destdir to FetchData
  fetch: npm: rework
  tests: fetch: adapt style in npm(sw) class
  tests: fetch: move npmsw test cases into npmsw test class
  tests: fetch: adapt npm test cases
  fetch: add dependency mixin
  tests: fetch: add test cases for dependency fetcher
  fetch: npmsw: migrate to dependency mixin
  tests: fetch: adapt npmsw test cases
  fetch: add gosum fetcher
  tests: fetch: add test cases for gosum
  fetch: add cargolock fetcher
  tests: fetch: add test cases for cargolock

 lib/bb/fetch2/__init__.py   |  35 +-
 lib/bb/fetch2/cargolock.py  |  73 +++
 lib/bb/fetch2/dependency.py | 167 +++++++
 lib/bb/fetch2/gomod.py      |   5 +-
 lib/bb/fetch2/gosum.py      |  51 +++
 lib/bb/fetch2/npm.py        | 244 +++-------
 lib/bb/fetch2/npmsw.py      | 347 ++++----------
 lib/bb/tests/fetch.py       | 880 +++++++++++++++++-------------------
 lib/bb/utils.py             |  25 +
 9 files changed, 916 insertions(+), 911 deletions(-)
 create mode 100644 lib/bb/fetch2/cargolock.py
 create mode 100644 lib/bb/fetch2/dependency.py
 create mode 100644 lib/bb/fetch2/gosum.py

--=20
2.39.5


