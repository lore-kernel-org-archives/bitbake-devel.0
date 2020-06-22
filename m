Received: from EUR02-HE1-obe.outbound.protection.outlook.com (EUR02-HE1-obe.outbound.protection.outlook.com [40.107.1.127])
 by mx.groups.io with SMTP id smtpd.web10.19053.1592837768377302508
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 22 Jun 2020 07:56:09 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@zuehlke.com header.s=selector2 header.b=Pjm2Kf9f;
 spf=pass (domain: zuehlke.com, ip: 40.107.1.127, mailfrom: joschka.seydell@zuehlke.com)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oLvY1WLfMMYvQaWBE21Rr5TySiJpnXdzHiSBQEJqkgMwa0IJpMhww25Hw/cj709eer1xrcrouMB7cRkxrPbZC+wmU0OZUS3ek2EI3CBiPg9AD7mk6ME4FNuZRz0+RFxwQT2L4IguFy3Cw5rNhjYbqjnLEpmuPzqaJGSKr1c6/ck6RK1dvRKyfeMsGjVxWJ4wk0S8lr3ruRUdZvRvq0CkH4NRjLQvJHF7w0hlKgEVPpRSVoL3O2sbSe/tlpS5fzVZI2dqt7REGw08T/gv2UAqwA9FYzX3sEM0mkFekJ8rVC+yZd7kouHd6FYlki7xrPET3ubjCVyjZcji/PgQuNPKlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/GnroRkx+yW0u7oW1Lfmo+zEMu3/aOgJ0Fv3dkngTg=;
 b=AVnRL2m19ATziXMP0J8/nNcV7T6iOsQY0fZaxKCHSyKs06pCRVgp4QRDBsXtftpV7poStmYFdONd+rz8gUhSkRWPX9BmOYj9BD9GukgfEa97lYmvNfSeT7Creic96YXEzmqKh5Utf1xNwDFPMN/okIFvDNpPv7DlJHefL4oifG0bbSByekP2wqWxyVk4Jf2edDwEJ7bnWg7c1uX9em0hJ+2qtcsqNKRc+bkwTqcxosCtAc5ORj++0WVX97Spu8mu2t67hy2W22PGJKJnwyD89kFdKrYkSauspS1QlzpXXa9yh4xK1fD+53chnOpXzlcEsVSQy/Hk6bV14xb2sg46/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=zuehlke.com; dmarc=pass action=none header.from=zuehlke.com;
 dkim=pass header.d=zuehlke.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zuehlke.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K/GnroRkx+yW0u7oW1Lfmo+zEMu3/aOgJ0Fv3dkngTg=;
 b=Pjm2Kf9fQiYmCsHWwSpE+QRSiK8pYgM4VUl6+j49xW8SmGS7gneXwhzr3vC7n24hTsxdXLmgiZuhsu3ZeHHIDDQ0SEaOCZzUmn7I7IuXKllW2hyonlJ9tyJqOMPgmXd5GBf2XawqhqVmdZVupabXh7DAoZ4bSIVWkEqLCtlsB28=
Received: from VI1PR10MB1920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:2a::17)
 by VI1PR10MB2639.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:e8::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.23; Mon, 22 Jun
 2020 14:56:05 +0000
Received: from VI1PR10MB1920.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e8a6:d7bd:d8be:cdb6]) by VI1PR10MB1920.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::e8a6:d7bd:d8be:cdb6%6]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 14:56:05 +0000
From: "Joschka Seydell" <joschka.seydell@zuehlke.com>
To: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: [fetch2/gitsm] Potential bug with whitespaces in URLs
Thread-Topic: [fetch2/gitsm] Potential bug with whitespaces in URLs
Thread-Index: AdZIo9EvD2/Kpn9YQWiGBgiEU99Row==
Date: Mon, 22 Jun 2020 14:56:05 +0000
Message-ID: 
 <VI1PR10MB1920276DD47E87D0F84F3B8FE2970@VI1PR10MB1920.EURPRD10.PROD.OUTLOOK.COM>
Accept-Language: de-DE, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-processedbytemplafy: true
authentication-results: lists.openembedded.org; dkim=none (message not signed)
 header.d=none;lists.openembedded.org; dmarc=none action=none
 header.from=zuehlke.com;
x-originating-ip: [2a04:4540:6b08:0:5919:fb9c:9c6b:633b]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2c62c61d-cd46-4b4f-be46-08d816bc63c3
x-ms-traffictypediagnostic: VI1PR10MB2639:
x-microsoft-antispam-prvs: 
 <VI1PR10MB2639D0280D578A593A28F1D8E2970@VI1PR10MB2639.EURPRD10.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 1hyZc5DEdvH5Uu/WFCDtt3m5DTW36K1ursIXyaR3q8vncVXAPVQDLxlTIUdj70jlf1deu/sTGfyOQbJXNKUKCDXBoszpJuSw9UCbS0CP5JFfdNxehwSRwugNzCRrOfY7v+Y4PfgxLdtae4cx9UwrBP1DKtxGUo+3gfE2Welojr2sZGEM5/mtVDAEFRGVixyvDLiGCOG9nYPFX0O0UzBHKm606DAiG5PSUskrkEzli/q0XVRV3rK1Pr9CNfTFkY+CI9WOAauoKPrsQfXIm3BnhPvCvux+CyCMQuvfAn8tV7918WwG2hUFSzohk9Xh2HesWAHMdAn76G6hmFBgB26wxQ==
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR10MB1920.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFTY:;SFS:(366004)(396003)(136003)(39850400004)(346002)(376002)(9686003)(83380400001)(4744005)(2906002)(6506007)(55016002)(33656002)(186003)(6916009)(7696005)(86362001)(316002)(66446008)(66556008)(66476007)(64756008)(71200400001)(8936002)(8676002)(52536014)(5660300002)(66946007)(478600001)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 
 O45XWX5eW428rQWaV8tVVcUogHfcMt4FXjqEufG5pdJiXArKahsilsbvypGpfe+PvFcKABn3hJauMyIyr/LXkOIoB39tZ0R2SYlN8OeR9v0jTPF0uDR3ADO5MB0dThOTxA3FHRHaLw2sF4CDw7JVmoMXsjjFsyM1xUp+DSttVav04y5qoEmyS/v5NdmZ6lXHbtLugKjDBtZnsFW4KMvkxajJ35xP29HPg+u0Qg5iVzcp4EKm08qAZFUa8rO1U1jVf/eZn0GAOSfm5Je0ZiKFgnn4uJqTFh7QbZo/BrS6HZNndiz1WxeEhMgK1+O3Om5pVPhsC0Gc4GWQu55OLbCyPqRnuh+7NsyAjFT9LCeBIJXF2ToH8cGCkd6ZosgKbD8tpTBa/uiMrORwaloSygyE8Gr8a+wnX4mLdYX8nf+ltEInyJK8BpmHoVIBN3br8h6dOaNVgWfA03cLpU5boHjGPFkwnDJ0QK3KIECJjjBRdnqWuFsRwBs+JhqiZqAKo1yDYCnrjavcj5z6nV1kbuqLruxEt9OcpkzXLt+mtEhgofo=
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: zuehlke.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c62c61d-cd46-4b4f-be46-08d816bc63c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 14:56:05.4741
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: ccce7f5e-a35f-4bc3-8e63-b2215e7d14f9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wTUwImhzK6TbckB49YOWLMXSP8FL/S6vXpCMeKE9NLSfnEDGphIcHOnNKI4nLX+JS5NhIxVnMoej6INeOSYIR6Y1HAFKBd5VE1mK0AkBcCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB2639
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hey everyone.=20

I'm currently trying to migrate an existing (building) project from sumo t=
o zeus and experienced build failures in the fetch step. I tracked it down =
to the following issue:

When the URL of a git repo (with some submodules in it) contains whitespac=
es, the gitsm fetcher will fail to clone it. The 'url' parameter is correct=
ly passed to the Fetch class, but 'path', 'localpath', 'clonedir' or 'fullm=
irror' are set (somewhere) without proper URL escaping (i.e. %20).

Did someone experience this issue before? Was there some major change in t=
he behavior of gitsm between sumo (working) and zeus (failing)? Where can I=
 find some breadcrumbs how to fix it and contribute?

EDIT1: I just found out this has been (partially) discussed before here: h=
ttps://lists.openembedded.org/g/bitbake-devel/message/10318. Unfortunately,=
 there's no fix in place yet.

Thanks a lot for your help,=20
Joschka Seydell


