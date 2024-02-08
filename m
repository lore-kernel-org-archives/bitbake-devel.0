Return-Path: <ross.burton@arm.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C04A9C48260
	for <webhook@archiver.kernel.org>; Thu,  8 Feb 2024 10:38:16 +0000 (UTC)
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (EUR01-VE1-obe.outbound.protection.outlook.com [40.107.14.74])
 by mx.groups.io with SMTP id smtpd.web10.14945.1707388691890594717
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 08 Feb 2024 02:38:12 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=UeLHXoIb;
 dkim=pass header.i=@armh.onmicrosoft.com header.s=selector2-armh-onmicrosoft-com header.b=UeLHXoIb;
 spf=pass (domain: arm.com, ip: 40.107.14.74, mailfrom: ross.burton@arm.com)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=J35mncuNf0QJvJKx8x7O+K4FuIMd4ycbaKPs6YIQh9bdj+Qhkj79046TIu7lrEmb9a1VpZBZ0W6LSjA7GKCv3ZVJaDq8JLy2wCBrOQpf9IQW/yCcm6rjY+UATJKMqhLGip2uNgH03uerQCurBYX1hjzQKbWUZomUuar797fGztPUn+s9GEab3yntAHmgqj9gNF5jhejIewYqdBWl8Okr1xCmR93qzFSpbQlGVMqZbA0Hdy3EqrRuW7VK5QZiNfiIGSLk7zm4VShC291F1HrczN0QYbr/OoIvbYLogNzI5APCZ3FeQXWE1us01XoAVkh7EUqjX0o/+2Z3WjuJ+FrnSA==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHkasPLunr2yDEeavfUR2BLZqxb1gDURqQLsq9E5iss=;
 b=BHs/3clTCPoevsNGogXPz6VTpsA33ijeMHKh1BTmWh0uY9SBzoHwhHBfWhL9SlZFx3s2opeCpcRBzUipPk7XtpL6PwkaGiVUg0Jd3FPOD5FloNRUPbuZNchBXjhyf+biFKQtUc3RcXhgs1Zj/FeXEaZQ/+4bg5yv6eEWLX0TQ1WRAdzILGJfX9fxHxi8XKjvgOxy+f8FGoMuq3CNtK1E5gRcTxe6kp+9RUpZgQACOGh00upB7t05wZvbke4Iv9kzO2kFFEYpuF3hJq4w9GhoV0MWsujECkT7NKSeySntnb5r7qZud0+YVXat+yWQWxIYfxiPbBNaskTiVe3X2Z5RHg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=lists.openembedded.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHkasPLunr2yDEeavfUR2BLZqxb1gDURqQLsq9E5iss=;
 b=UeLHXoIbSzz/Q0OWoLyYCVGOBaeZ3yFI9XXxWRwOzT8KFL798ZQalxf788DjgZmkJVbyfNjYC8aXFyAYPxsara/tHfG1MyvSf033qRXbDf7KiLe6AUgbhErnvwHjFeIzMWSlqjF9hCRpip+0glAXjU3zcLiikMf+Nsxq0/hVlDY=
Received: from DB9PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:10:1db::28)
 by PR3PR08MB5802.eurprd08.prod.outlook.com (2603:10a6:102:8a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.39; Thu, 8 Feb
 2024 10:38:08 +0000
Received: from DU6PEPF0000B61E.eurprd02.prod.outlook.com
 (2603:10a6:10:1db:cafe::90) by DB9PR06CA0023.outlook.office365.com
 (2603:10a6:10:1db::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36 via Frontend
 Transport; Thu, 8 Feb 2024 10:38:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DU6PEPF0000B61E.mail.protection.outlook.com (10.167.8.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 8 Feb 2024 10:38:08 +0000
Received: ("Tessian outbound 31df1b57f90c:v228"); Thu, 08 Feb 2024 10:38:07 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0d7064b3d1efd4c9
X-CR-MTA-TID: 64aa7808
Received: from 0b4ed8c1bc7a.1
	by 64aa7808-outbound-1.mta.getcheckrecipient.com id 2576D9DD-6761-4387-822A-807171BA2193.1;
	Thu, 08 Feb 2024 10:38:00 +0000
Received: from EUR01-DB5-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 0b4ed8c1bc7a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 08 Feb 2024 10:38:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E8pM1Ma9Pr7dhbmjHCAJ3wBT4FfXgAF23SxIdfGIrllFIdUw+bwqwWLBvDg1LIropdlGq2y0l2liHNJh5VbcmfP1ODHG8lFQPTYxH7dB/z4eJc/GgDmF3kO0rR3LywIL6j2Y4Rz1szTCsJoP5rTgb07dQo931yL6XZq/Q4sb7WZkGEsAjIGAzd+Uc7nKgIjyOUwqtQXS/AT4UzwYfeQmX6BAvUys1ePdiWwic7Ob/6L7EQMjAMyZUVokZlW8j0AjOjssCYaLbQpTlXUFuSc/vAkN+qukbSoGQOKaxX6p4QH4NlxIMdfJUeqRFQ8wFe5fEL+Gcv5E19/8VUunL6ZNKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LHkasPLunr2yDEeavfUR2BLZqxb1gDURqQLsq9E5iss=;
 b=CsgvKqukk+lXZYj9UxSYZq0JXdpKb0u96VzVnUiHSZKWFLxVjmNA+xkIvyTICako2NGTJYl/qK9FgZdZRwVP7NsQvcLPP07bDau4d5A7o/gZjB9Fbw51inhZMsq8OqOcpDcYeJ9p25FOJ2tMKGP4e7MiwIu/RVYYlvl1ly39k/Od7yXTRm/RYfizZd7DLfVmibIMsR1cXrciyNLrtq5nt4EQdOQDxGNfaLjBlyG4bRzB9L5IrdJgYz6HHNd5dqsWIN7WhCP+YHaV4D2mswKV+Ap2RZMHUmSab5kiyxDdbtOF4PStzB0pNM3QDyedgVzCrrRjRIKuWuwhvN0bN8BwrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LHkasPLunr2yDEeavfUR2BLZqxb1gDURqQLsq9E5iss=;
 b=UeLHXoIbSzz/Q0OWoLyYCVGOBaeZ3yFI9XXxWRwOzT8KFL798ZQalxf788DjgZmkJVbyfNjYC8aXFyAYPxsara/tHfG1MyvSf033qRXbDf7KiLe6AUgbhErnvwHjFeIzMWSlqjF9hCRpip+0glAXjU3zcLiikMf+Nsxq0/hVlDY=
Received: from AS4PR08MB7429.eurprd08.prod.outlook.com (2603:10a6:20b:4e1::9)
 by DB9PR08MB8676.eurprd08.prod.outlook.com (2603:10a6:10:3d0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Thu, 8 Feb
 2024 10:37:58 +0000
Received: from AS4PR08MB7429.eurprd08.prod.outlook.com
 ([fe80::f686:f930:a9cb:fbf6]) by AS4PR08MB7429.eurprd08.prod.outlook.com
 ([fe80::f686:f930:a9cb:fbf6%5]) with mapi id 15.20.7249.039; Thu, 8 Feb 2024
 10:37:57 +0000
From: Ross Burton <Ross.Burton@arm.com>
To: Alexander Kanavin <alex.kanavin@gmail.com>
CC: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [bitbake-devel] [PATCH] bitbake-layers: add show-machines command
Thread-Topic: [bitbake-devel] [PATCH] bitbake-layers: add show-machines
 command
Thread-Index: AQHaWeodaae28NyMCEWFq+UdcZe8VrD/SZyAgAD4RoA=
Date: Thu, 8 Feb 2024 10:37:57 +0000
Message-ID: <53F93B66-BBA4-4FFB-8550-D95AA14ED957@arm.com>
References: <20240207172121.4044574-1-ross.burton@arm.com>
 <CANNYZj_vLSgRzA6EE5v0dccF8hs+DD3Gwxfs5ATCVGnszW++Nw@mail.gmail.com>
In-Reply-To: 
 <CANNYZj_vLSgRzA6EE5v0dccF8hs+DD3Gwxfs5ATCVGnszW++Nw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3774.400.31)
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
x-ms-traffictypediagnostic: 
	AS4PR08MB7429:EE_|DB9PR08MB8676:EE_|DU6PEPF0000B61E:EE_|PR3PR08MB5802:EE_
X-MS-Office365-Filtering-Correlation-Id: d74ebcdd-da7f-4a17-0934-08dc28920a26
x-checkrecipientrouted: true
nodisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 
 5KpD+869yz57pkbpWSTbRBGy5ptO/4pmF4uR4GT614kmc46VWXCqOH5YK06dKxWqfdtW97oSd7EvbWsFKmbXERbYxrchyTcBuVI6uPN3fW1Y/lBY4pfdQsD6YGgidnyViziilmfbIUhXuvs3qysARIXua8Hqfygg1iQ0yIX3StRdLehEKHOoQksndx29Y6X1IATETmoZ5iiHQIgww1s479MzF5dbrJlo3O3DrB1tMoIU06Tnf5wQrOmJGSV91qpHQ+tLm0S1ZJuwAy2el0c1EwgWhmjWFC2mvQp+jP1MC3d5S6V3J412aCc77CwgilJhqYb6wBhDKGAWiklBheXEIwQLfx4hqr0tA4c5Ps1/jM+qj1ShoVbWb/DPx6EIle8dGb7yhgjc0IaW3Q6gdDiZ/P/5caY6mzvyTzcQ+cSHpsAsudXQem+540IqQECXme8CNyfLAfFIaZxRz8dtiM5lH+WQ9ETMs/WHyOOct493QV9x5UWkD314obKONvv3Q2OCy9AA3buKWpclcDPk6XGG1WqkGNNq8mjLscTpEtwAXZM+RZnO+8Z0rpfmhPsh+wBZ7wqPmi248Ovposn3OkARrURGS8Zr6MAGxRhpnoqgMQE=
X-Forefront-Antispam-Report-Untrusted: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR08MB7429.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(366004)(39860400002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(2906002)(5660300002)(4744005)(41300700001)(66476007)(122000001)(26005)(38100700002)(2616005)(86362001)(66446008)(76116006)(33656002)(53546011)(64756008)(316002)(6916009)(71200400001)(6512007)(66946007)(6506007)(36756003)(66556008)(966005)(6486002)(478600001)(8936002)(4326008)(8676002)(38070700009);DIR:OUT;SFP:1101;
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF3781CF7BBED54788A910BB645A5F72@eurprd08.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB8676
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: 
 DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 
	59614ab2-f130-4ee5-dbb7-08dc289203cd
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	B+F/G3+oIemAgqaf8PZKskdODaHrbDEkH19Mra0V3Nvg31sh/qSPxdTh5J+M72L77thSHAnNtJ7dWYgbR3kgkjtPkxIaOBi+Avn84DxWDK7K68c+yF7ICZOIIARrQfU1gthvMq/eDNJYfI7abucn0uDDMWqF4SGlPYaUUp73xyio+mfB0q9j521Afp7AjxHoDWqdKX5EL+zrGBdkkzAmnn+i07JhhwSL7e25fzlW7uLa7SikmLYkhj50+ZB+DM7dzMtxF9udy4B1OSbJhW3Xv2pYk5Ag7HBrjTp9zmec7cJ/JsZCqZWFMgv33F+VvDSzkYz6M6+k9UWPUYo8Rvh7u3IpBMVRxvFEWXO0qmY/WwB3mI8LGllNpTa/NfeAKXJWLKSlhTSKG6d1QlWMyXoV3WKSzsbiXOO42M7zAKQ6GgE40eVbQxCZSh74r+Vg3eH0c3lWXmM3+QVjdgQpVEE3f5QbAD7ebF1yCib98unQLT2yUmyGuSWu2rKlMRmNqX2JQkN4eZZWPXrFYtYm6axuFJddFW+VcXVFVA750W+/1I4a5aR2tPDOPBioLIgxOtdP+T7/0/xCPdOcMYpUyXf7hA==
X-Forefront-Antispam-Report: 
	CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(346002)(136003)(396003)(39860400002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(82310400011)(46966006)(36840700001)(40470700004)(81166007)(82740400003)(356005)(8676002)(86362001)(6862004)(8936002)(5660300002)(4326008)(70586007)(70206006)(316002)(2906002)(4744005)(336012)(966005)(6486002)(26005)(478600001)(2616005)(53546011)(6512007)(6506007)(36756003)(33656002)(41300700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2024 10:38:08.0368
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d74ebcdd-da7f-4a17-0934-08dc28920a26
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: 
	DU6PEPF0000B61E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR08MB5802
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 08 Feb 2024 10:38:16 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15839

T24gNyBGZWIgMjAyNCwgYXQgMTk6NDksIEFsZXhhbmRlciBLYW5hdmluIHZpYSBsaXN0cy5vcGVu
ZW1iZWRkZWQub3JnIDxhbGV4LmthbmF2aW49Z21haWwuY29tQGxpc3RzLm9wZW5lbWJlZGRlZC5v
cmc+IHdyb3RlOg0KPiANCj4gSSBoYXZlIHRvIGFzay4gSG93IHVzZWZ1bCBpcyB0aGlzIHJlYWxs
eSwgaWYgaXQncyBhIGJhcmUgbGlzdCBvZiAuY29uZg0KPiBmaWxlcyB3aXRoIG5vIGhlbHAgZm9y
IGNob29zaW5nIGZyb20gdGhlbT8NCj4gDQo+IFNhbXBsZSBvdXRwdXQgOikNCj4gaHR0cHM6Ly93
d3cuaXJjY2xvdWQuY29tL3Bhc3RlYmluLzNNbVlOdUFELw0KDQpDb25zaWRlcmluZyBob3cgb2Z0
ZW4gd2UgZ2V0IGFza2VkIOKAnGhvdyBkbyBJIGxpc3QgdGhlIG1hY2hpbmVzIEkgY2FuIHBpY2sg
ZnJvbeKAnSwgaXTigJlzIGZhaXJseSB1c2VmdWwgdG8gcGVvcGxlIHdobyBkb27igJl0IGtub3cg
ZXhhY3RseSB3aGVyZSB0byBsb29rLg0KDQpBbHNvIEnigJl2ZSB3cml0dGVuIHRoZSBzYW1lIHNj
cmlwdCBpbiBzaGVsbCBvciBweXRob24gcmVwZWF0ZWRseSB0byBhdXRvbWF0aWNhbGx5IGJ1aWxk
IGZvciBhbGwgYXZhaWxhYmxlIG1hY2hpbmVzLg0KDQpNYW55IG1hY2hpbmUgY29uZmlndXJhdGlv
biBhbHJlYWR5IGhhdmUgbWFjaGluZS1yZWFkYWJsZSBjb21tZW50cyBzbyB0aGF0IGNvdWxkIGJl
IGV4dHJhY3RlZCBhbmQgZGlzcGxheWVkLg0KDQpSb3Nz

