Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F351C433F5
	for <webhook@archiver.kernel.org>; Sat,  1 Oct 2022 19:58:18 +0000 (UTC)
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (EUR04-HE1-obe.outbound.protection.outlook.com [40.107.7.51])
 by mx.groups.io with SMTP id smtpd.web08.1169.1664654292381648301
 for <bitbake-devel@lists.openembedded.org>;
 Sat, 01 Oct 2022 12:58:13 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com
 header.s=selector2-armh-onmicrosoft-com header.b=89WPA9We;
 spf=pass (domain: arm.com, ip: 40.107.7.51, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=h1I/Y/Y9246WNBl+9SvBjpfATnzstsmaBs4PRfmmTRrIO6sqPyCM9rRLvareZgNIuaIMSI4poD2qO82wrSetUDnZWRrSCiFwWpM2EA++wPtOdOeheEeemd9U8zHXjrt1QhYU0u4XtfsT+iHN9mHLlcnl/NfQVkXDGzsY+XCO9kWnCwSBsWEByTcLbPXfZyJEw/zpmBMHqAG6z1Ww+p6Npqgd2zUnBlbHh57L3cvwC3EaJ43poBaw+fCoZ0dVvx0GisSdzsfv19wKBsrNseAJ9TEMk3mvn/MLcc3xpsenLpYhBBkDShf8ahNv7BHPlZtJ9M9omFNNCUy5EXRLOhaq/A==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gsKLZYzC+oLQBbwiWWIdnM1Yx58PtejHQUfGfqP3Dg=;
 b=M3xwZvvMXBSK/AgJurJJjuXT/lrG9snPRnzjaoI1wY81Wslom5qWoKZiBu/y5EOh40R88r8dZgep6oPOAje2zh2e1BYpyMExJMI1xx9CaQR2DucZmxwBEBNVKClTueZ/aAZSVJ5uVgo7nvfBddT8/g0GAjlSEABWanFzWHYBKX94QQ56ZT8YCeFloBN2PI+CE1q2uLuU4jwbM5rAXxfoDozkqSueE9FEkUpLIZpgZi1ltAQ0lDdGT2uSegbZJMNkXazGz6rx5wZ4wSPf9jzdJgTGm7tXC/bJmHUl2rp1aENDrVGHgAVxJGdZXcMG1R9B9PLgImYfvs1Dbepdpiu3Ow==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gsKLZYzC+oLQBbwiWWIdnM1Yx58PtejHQUfGfqP3Dg=;
 b=89WPA9We+qM0W7zZDhs3+fkxJyNZqtXBqg+UnzTrFtPxjfBNIWrSynLfWJ3I3yYuvj+bpiZhtD5PWNfsafp3aYc4+tMfAR/do3Fzl3vQ5Q6LRzqtS1LDe8gtSMU7PQdGCFIEufEPCcl99hkvgdUwrtGwfIB2eEnA6pmOcCvJHc8=
Received: from AS9PR06CA0693.eurprd06.prod.outlook.com (2603:10a6:20b:49f::9)
 by PAWPR08MB8885.eurprd08.prod.outlook.com (2603:10a6:102:339::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 1 Oct
 2022 19:58:08 +0000
Received: from VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:20b:49f:cafe::46) by AS9PR06CA0693.outlook.office365.com
 (2603:10a6:20b:49f::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23 via Frontend
 Transport; Sat, 1 Oct 2022 19:58:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT050.mail.protection.outlook.com (10.152.19.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5676.17 via Frontend Transport; Sat, 1 Oct 2022 19:58:08 +0000
Received: ("Tessian outbound 7e4a920b87c0:v128");
 Sat, 01 Oct 2022 19:58:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 1f6e9aaf791fa5ce
X-CR-MTA-TID: 64aa7808
Received: from 4d0ab8217245.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id
 23607A3F-34FE-440F-9246-111FE3F12E0D.1;
	Sat, 01 Oct 2022 19:58:01 +0000
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id
 4d0ab8217245.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Sat, 01 Oct 2022 19:58:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G35vSA+earKANlG0d2GmZ5bPJsM+YSAl4Kz7B/yYmFbMFz9lFy5KCi4CA+GsMQrFCRgpzLIZOPKdmBtEgDN3SxDEtPrgJhA9MeWsGSkalCvaWHmDn1kYfouMYnZZ0WiF5eDQVuzANDVTKnPwKMVbFGp7UZhCgfSC1TNSyBLf3hrUuj0gC3RuK6LNrpny03m/1g+G+3jsFVKySNaSy9X6yM9nYefSbrXu8k73gK9Pznrjp6chSd+90wSolTC2ME1JUf3btOYL7UMXlWSQ9nRnfHo7jWQBCmNUjbZZhUhsV4riEApPLjyy0mpVcgIwA6X6xxD44oxHi0+e4089Jab4LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7gsKLZYzC+oLQBbwiWWIdnM1Yx58PtejHQUfGfqP3Dg=;
 b=g0cAGZNO1cQuqp8A9GJ+3fRLp9BV5YYVpAy4jeUxfeGY5CV6Rw4NRM/8LRchcxgjcxuaFMk48kOGAHQ5zbW/JlgXXAdoYcYjpjT4618cxaUUiIBgkN61E16u0KTLoAkX//tHIR+Su5OB/uJfHYv2DtBE/i0ZtYiIyam9n72wj+Gg/pLYlQaygH4mMavWqf2oVf+eCJk2CcHtZ7bqP0InXNTea++JCBPAdqkU4pi/75t8GlHpZZOijldiIOMaf3BUF4thm0ZCW+LK6vcgsXY1QdU3bVty9Um3F7EbDatNkgZuYpJnYa91sBQuxoKE1D6gnVcggr2rqdOH7L+2SZUfUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7gsKLZYzC+oLQBbwiWWIdnM1Yx58PtejHQUfGfqP3Dg=;
 b=89WPA9We+qM0W7zZDhs3+fkxJyNZqtXBqg+UnzTrFtPxjfBNIWrSynLfWJ3I3yYuvj+bpiZhtD5PWNfsafp3aYc4+tMfAR/do3Fzl3vQ5Q6LRzqtS1LDe8gtSMU7PQdGCFIEufEPCcl99hkvgdUwrtGwfIB2eEnA6pmOcCvJHc8=
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com (2603:10a6:102:2a3::12)
 by DB8PR08MB5532.eurprd08.prod.outlook.com (2603:10a6:10:f8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5676.23; Sat, 1 Oct
 2022 19:57:58 +0000
Received: from PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7d2b:2570:9a99:a3d2]) by PA4PR08MB7411.eurprd08.prod.outlook.com
 ([fe80::7d2b:2570:9a99:a3d2%5]) with mapi id 15.20.5676.023; Sat, 1 Oct 2022
 19:57:57 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: Nicholas Jackson <Nicholas.Jackson@zii.aero>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
Thread-Topic: [bitbake-devel] [PATCH] bitbake: wget: fix netrc with pseudo
Thread-Index: 
 AQHY1PXAIuJAgPf0bUqYJXLo7cYeDK34QvoAgAAAOz2AAB75gIAAAulegAALRtiAAAu1gIAAA2uAgAF2y4A=
Date: Sat, 1 Oct 2022 19:57:57 +0000
Message-ID: <EE055CF5-FB7C-436B-A526-3A05FE023513@arm.com>
References: 
 <BYAPR12MB2710069E5D018DBB8F800AECF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj_Cr5QO31dqnrNV9051M4fVh79Z3ayq8xF9DxLyRriDgA@mail.gmail.com>
 <BYAPR12MB2710359C1636EC9716B3EB83F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj9ETtBH1mY3x3G2Fe4Fjyni7zkRMcA9UsYtpBcTznUQDg@mail.gmail.com>
 <BYAPR12MB2710778AF2346FD1E8FAD51AF5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <1719BDC7DCD0DABC.17026@lists.openembedded.org>
 <CANNYZj95vsnNLd97LzL7ix=JC9HCReJo7VNa80EymiSRYNgRiQ@mail.gmail.com>
 <BYAPR12MB27105A444B6963892070AE56F5569@BYAPR12MB2710.namprd12.prod.outlook.com>
 <CANNYZj9RuBP-btf5ATGx7pTqiP=-bzeHttY2GM=A9t+HQLo=5A@mail.gmail.com>
In-Reply-To: 
 <CANNYZj9RuBP-btf5ATGx7pTqiP=-bzeHttY2GM=A9t+HQLo=5A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.120.41.1.1)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	PA4PR08MB7411:EE_|DB8PR08MB5532:EE_|VE1EUR03FT050:EE_|PAWPR08MB8885:EE_
X-MS-Office365-Filtering-Correlation-Id: 8151757f-cac9-48f1-a8ac-08daa3e742ec
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 /HRZpGnw0xF3oyIOzK3bMJrQmG3pn84j1CRP33pPMNA8IJao3P61qlSaUpsklQgezLPAiMq7d+Y7JosihUPEgKtvT8QN3alXvBnfqIJGfYjvXbGHI9xbeDYgyMR2k+3SNAO/3tVPUc2MAPRKeAA+6hZOutWtKgnP7ayjVh3kKbe5KqJxQooUDuRvYHynN31Y0dmJEQ6CELgUs025LFVr84A4JTICGLeWMtrsXhOr4rGbALFnsGXy7ltxxwZijzvy9Ev/tfiorgjSrZzBjRAkjhIn7TRHZ2NXY1eVEg5yjr9JuG5hWDSfv4YescEgS1uVRUz03fn68cKJ9IvDZ9A+xAXNXjUfo7Ktkn3sR0r+UK/BULgjMymBWiZ/OzPTWWsMdRxiQsf/p4OClWRoXWyrEoR6rEfcC97ihZZrn2LGxoNHRiiM6u47cLOh9vYQM7wX0ocTP6ybQ7kPxC0KkGFPlVbqgfXHLzTsOsDI8SMTmpkNd9PrJW22X3Zy2ZB+H4wtCJaurO0HQ5tgBhK3b1RSEsHq3kweL72uyRXe4+RMO0RAfEtRXaiI8+3gwnOjrkUG7rpWdOLnd2MSCBbLBo67+WAUBj/RH8syMT6JNXFz1UPYhpc9it94iYt9tyxieqTKJXSB3tIF87HvRvDZdh+sRbYtWLV497ZgGOsQqywvmTanwWpj2Xy7PNKZJcwQIXP1fyw/Uty4ViyXOIk5PZyDnTnWLkkg54A3CIIWA/U5IotIOftTkcKxVvjZV0eXjILFVN03brDOD92wWXQvN8DcMvDTycPfUzXAdoEMUYxawQg=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR08MB7411.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(39860400002)(366004)(136003)(396003)(346002)(451199015)(41300700001)(91956017)(316002)(71200400001)(54906003)(66946007)(64756008)(66446008)(66476007)(66556008)(6486002)(76116006)(5660300002)(8676002)(478600001)(4326008)(6506007)(53546011)(6916009)(6512007)(26005)(4744005)(8936002)(2616005)(38070700005)(2906002)(186003)(38100700002)(86362001)(33656002)(122000001)(36756003)(45980500001);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <124D24582AD7DB4D8F871ED9DFF9DA00@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB5532
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	53a5e642-89f7-4995-68b4-08daa3e73cbf
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	YY8AptSSbQRfGKFdWk9ri9QHTtlZ4OKOAE+JwSq0jWKwjy3TQK4eaIOra8K+aq2bFqgypp8Cqf3jK9rq1lvr/k60pJHvOemsnC35rx2NjnKKrz0vFLncMflP9SS62yOZADxE/xitostyzXN3FsEVH3va3hwIhmVytVU3pQyLu8U932WZPlgIziZl7GN3vdIOe2BVEeEmqhUqRuwovjL6c84GRNpLytcjPUTysIPeeRnccSCBvaQUUA7A8djsWg8QaK8NiaCuPCwkFcP3jIsVUG2popFUrsKfAixHT5DQdHc4EQGJDL9gvo1lA4XSssPIbMx12ctuEBYKusEG7uE4wg/Ny7/0/9jvjgm665bqqlx6CZiD72eeMeXVk44u3l+MjjtP1ERy9WJMdN8EP6jmKqll8HnMMWwIAKoJghmPl4kvPfA+IJ/nFehEhcJ0XgzascZtmDw/WOTUqQXdBipTbftdeQrWubDe4tWJNoy6EfKICvQtjrERWFgmWDx987BbcOWUfxGr/pRQ/rKC5RO7mvSmnRQhRJgWSzpZbROESTHRuV+gCIhdwSr5sRGbqm04B44y1OmuBEVL8CLarMfS+IlJj+hJsjzOvin+yRvvHdIbNW3sotG/8Xt76suTrbc62A3F8Uh7EXjGlVkOBLzkQK/64mY//O4cqkKsJphZQ9JFb/E+tOMOrgliFYoufnBD061BhqVtav6Dq2f1LkZjH1BK/2bQK88ho0KnOrky08wJ5aDsbfgsZ2mY2ipyqZHfAhBnP1ww0f/gGwAVnF60tA==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230022)(4636009)(376002)(346002)(396003)(39860400002)(136003)(451199015)(40470700004)(46966006)(36840700001)(53546011)(36756003)(8936002)(6506007)(6862004)(40460700003)(6512007)(26005)(54906003)(81166007)(47076005)(8676002)(82740400003)(40480700001)(5660300002)(82310400005)(86362001)(4744005)(36860700001)(316002)(478600001)(6486002)(33656002)(2906002)(70586007)(356005)(336012)(70206006)(2616005)(41300700001)(4326008)(186003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2022 19:58:08.0857
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 
 8151757f-cac9-48f1-a8ac-08daa3e742ec
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: 
 TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	VE1EUR03FT050.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR08MB8885
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sat, 01 Oct 2022 19:58:18 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14010

T24gMzAgU2VwIDIwMjIsIGF0IDIyOjM2LCBBbGV4YW5kZXIgS2FuYXZpbiB2aWEgbGlzdHMub3Bl
bmVtYmVkZGVkLm9yZyA8YWxleC5rYW5hdmluPWdtYWlsLmNvbUBsaXN0cy5vcGVuZW1iZWRkZWQu
b3JnPiB3cm90ZToNCj4gDQo+IFRoYW5rcywgSSd2ZSByZXByb2R1Y2VkIHRoaXMgdG9vIHVzaW5n
IHBsYWluIHB5dGhvbjMgYW5kIC5uZXRyYyB3aXRoIHR3ZWFrZWQgcGVybWlzc2lvbnMgKGUuZy4g
cnVuIHB5dGhvbiBhcyByZWd1bGFyIHVzZXIsIHNldCAubmV0cmMgb3duZXJzaGlwIHRvIHJvb3Qp
LiBJIGFtIG5vdCBzdXJlIHdoeSBmZXRjaGluZyBzc3RhdGUgaXRlbXMgaGFwcGVucyB1bmRlciBw
c2V1ZG8sIG9yIHdoZXRoZXIgdGhlIGZpeCBpcyBjb3JyZWN0LCBidXQgdGhlIGlzc3VlIGlzIHJl
YWwuDQoNCk15IGh1bmNoIHJlc3BvbnNlIHdvdWxkIGJlIHRoYXQgc2V0c2NlbmUgdGFza3Mgc2hv
dWxkbuKAmXQgYmUgZmFrZXJvb3QsIG9yIGF0IGxlYXN0IHRoZSBmZXRjaCBzaG91bGQgZHJvcCB0
aGF0IHBvd2VyLg0KDQpSb3Nz

