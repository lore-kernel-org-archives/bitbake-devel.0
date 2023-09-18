Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10BC1CD37B0
	for <webhook@archiver.kernel.org>; Mon, 18 Sep 2023 09:29:23 +0000 (UTC)
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by mx.groups.io with SMTP id smtpd.web10.47365.1695029354769851786
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 18 Sep 2023 02:29:15 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=Ol2EifRe;
 dkim=pass header.i=@axis.com header.s=selector1 header.b=OVzszosY;
 spf=pass (domain: axis.com, ip: 195.60.68.17, mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1695029355;
  x=1726565355;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=oF/53r7rTx9P5xERBTBI3v4DIpUQCIgAh6JtFVb/h8Q=;
  b=Ol2EifRejz+wOLJ5O+lRmVhUCjcVLdI94Qgf5Ltl7tpAk3JKVDVPiX+g
   uddUwbEXg6f3+S9QAyatZSV/tkXipw93p22arM323mKc+h8Z+LELuAIwJ
   PSLkTtfJtweDbEZW8/pSKEWgsRcdg8TeF+jh2NrdmexAc1eXZ1U3kQ/i5
   zzF+2xXZiW2TrAdky4+bITjwkpmRosqoKSV/7/h5rdQXbGsx+Y3mhE9iL
   I+rrp1y26YKyQyIPGiTz7AT+tsCavK6O6TFIyIhpg/GygB1OODOfOv78R
   EkMy94pf/oOpP8egjM8gzcsMPfsFDXEGfGlBplU4UM9564nYiXtOioWDy
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hS42rZKv2YRtaFo2KYHY+gISw/C3+B9/lt1pmDIe+xTKfn/OieXgvIrKgiLpUdwuAXCOugK0urBK79Cdk3qelJHFYo0M+FGWXqPzid9NGedw/l0hMrL90vjwvLvVOuiUFLjhHzKknF0zXhFOKRfVJF0pnjOvYK1Zq7MZ3NkWjFn/U7Empm3kEVLGA8iDVtcgWPzI0oZJNi6oNoOK134vZNdswyIPfF6SUYwbOglo4iyUmIMvjkbWBWw2TucRkIrqSOkTx5vyZEDN6ZhM4u5BGCAUbAlbNg2kMHfv3dng89zEsoWJSJ7phaNbgxAsIzO+gSur2Un5V4C57BFMyWQyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oF/53r7rTx9P5xERBTBI3v4DIpUQCIgAh6JtFVb/h8Q=;
 b=nJYOze90fFE6mVOfa7qqQl06DfjPUkRvVQVMDR71ixBqRXeZg0f6vtrOeT3t76DQoqdNtVeTcxKd8SvxHt2ZosI/DdmksJoNLpDe4N0NR3TPNrzePYcPekJqDUaE7Roo44Z0ap0wmG353kngYsnrziM05ZflxAIaknMcHi2LaXd1AZBXb78suFn//E7SCeeKkTwUhiK/ETcQY3h2bKgtwQGnLZ1jLe/zOwBu5zULYTembvxJq/nkLY8iM5PgTr8rzFQTa9ILfmIDrjXH+eFuHrVO7JdVKNZcBI7zUOuRAmSNNFbdUYeKHoLGloQY8ORcCIOgQHUfCE4xhQOtJ5E7lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oF/53r7rTx9P5xERBTBI3v4DIpUQCIgAh6JtFVb/h8Q=;
 b=OVzszosYtEhUGBqETQ2tq25G8ipg7tq67+X5G9PYTBApSXU3yGQsI0hVB61FxGnYpxYB7cnWvQWuJmfAXqQQIrlYDmg1cWmsOY3YKh4ZmhPF9cdhRFrUtvAOpmwJ2J9iq1BedOrVBR2tj/dl8cTgcxWKVwfOT1YYwQQPJnovpsQ=
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Matthias Schnelte <develop@schnelte.de>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
Subject: RE: [bitbake-devel] [PATCH v2] fetch2: Adds vscode devcontainer
 support
Thread-Topic: [bitbake-devel] [PATCH v2] fetch2: Adds vscode devcontainer
 support
Thread-Index: AQHZ6WLhAfYrc/7qM0mHzm6/cwrZSrAgUcAw
Date: Mon, 18 Sep 2023 09:29:11 +0000
Message-ID: <DB5PR02MB102135361BD35DAB81D335C03EFFBA@DB5PR02MB10213.eurprd02.prod.outlook.com>
References: <ccc1cddd-3dee-4495-b41c-2dee2b2fe238@schnelte.de>
In-Reply-To: <ccc1cddd-3dee-4495-b41c-2dee2b2fe238@schnelte.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DB5PR02MB10213:EE_|DB9PR02MB7020:EE_
x-ms-office365-filtering-correlation-id: 07f130ff-7fe6-4f0d-7dc5-08dbb829b765
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0VAaqJZxaI9K2e3Y/U1Ni12/mnCqIBTU3Gucei8ElpUHZzgnOn+WQXesoWkv81QBS96y9O96sR4raNmWMu2qboH3Uq9cy5DE6qLS1NHsqDaIPyZNexQqTJN/TsektMeQU7xfa4Ezl23YJLLozrryShSSnDb7knWlQKyx9VmMuHBEjn7PwjjvrFyngFGp+45vKLMlQjy3V+SY9c1636dBaTO3h5sZTWGC4pMgsPiGVSAwc7YBjv5CznmJNsZyuH6IfgrLG3v9+G+8FBzHTroz/EVnvu+CWZIMmjUdlNKat6ncy/m0I0WherBRTAAO+ATIdv8g3ce+7I7U8E6XfocsiyOIlrjPAwuzFPwBPyORpWKjdJssQciLY8t6zPGYUmEMry178/RylRIpzw2+RdnsBkZ3Ztg3HuTzeFDx6SWOk1w+rEn7h1g78FSYlNcID2wYjgoxlp0VkJC8CBLo9S9tUQH9ypMWCsGeuHmcQDtr/gnh66ydSrkI2dZkWpBrjVerAhRdhEUCpU/SoaUzzSrOho9LRnuSll0W05+qqkX3WqTFtr7BPA1ZIwcSpRqIzQwVFqLALFmKNDmzTuceGsCqOUjhMOHJTCRuZBHuh2ibeZA6dHF5X7yhuulB55Mmk2Vv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB5PR02MB10213.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(39860400002)(376002)(366004)(1800799009)(186009)(451199024)(7696005)(6506007)(71200400001)(478600001)(122000001)(8936002)(8676002)(38070700005)(52536014)(86362001)(26005)(38100700002)(110136005)(5660300002)(66476007)(66556008)(66446008)(66946007)(44832011)(76116006)(64756008)(83380400001)(2906002)(41300700001)(316002)(9686003)(53546011)(55016003)(33656002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MlJjUTNpejFSbXdYWWptSDN1Ly9rdkhJVkxqcW9PbllQL3BnK1R6OS84c3JR?=
 =?utf-8?B?emhmb1Rqa1R1L1hsenJFOEZsN2ZEeDM3RWFTSW94K2JYdy9oMVhIQ2o5S1RT?=
 =?utf-8?B?R1J4bUU5UllqZHY3SUJRSm1odGRUT1ByalgyTUtoL2k3RkhJVzArQldvVUh0?=
 =?utf-8?B?a3U4TjFMVjVsWGVrQmxjRFFTVmZOdFZ1RmVQeGxKMVBuWUlkczMwRkk3cWZE?=
 =?utf-8?B?S3Y5LzZYNCtJajBadDIrMm82NDBKdTlPMC9tR3o5aWIySWVZNy95SklIT0lI?=
 =?utf-8?B?ck1WT0NiZDNwSFRXY3FreUVNSzQwTmwyS093endGb1NWVXExNWNhWmNvdXJj?=
 =?utf-8?B?bzhSRStuVlpSbWlENWNqdGc0Q0ZJcHVXQ1lxRFFlYkFhVmFaOS9nVWw3Vk1z?=
 =?utf-8?B?OXpwNlpyRFNxMElxbXczTTYxTjBHN3E4S043blpkazQrNWRkR3RlK0w4elMx?=
 =?utf-8?B?YzNZMnFNb2trcmlxK1hIRDMzY3MvV3J0QzZFS1RGNWxrbHFHSkVLVjBETVNZ?=
 =?utf-8?B?WThkVGVvakhzRlQ4MUtONmdrYVJWczBLVkhRMHpmWFE0UGVaQTc5OWpwWVRG?=
 =?utf-8?B?OGdGcTRDWklDbVBCWnM5U0o5eWx0dlJ6bXZPYjR1QjJGZnVWc29zU01ZQXd0?=
 =?utf-8?B?eGRJK25laHU4Yzc3cjY2UHRyam1GRXN3aVIxZXNQWVZIK0pzTWFpM0t4TEh4?=
 =?utf-8?B?RVJ1UGFpMW1EN2cyc0ptUURWSUY2bjY5c0MwNE5PSFJjSy84cDJlYzExZFMv?=
 =?utf-8?B?WWI0M01NZ21NVDduSzEzbm9MbFE2Nmk0MktiWmxQOW9MRWUxTjJBaTJwRnky?=
 =?utf-8?B?QmtFUTY2M2lpdlFYMHhhYVRqTXRWQW5EcDJyc2Z2d0tHaWZkdUo4NzVlTGVq?=
 =?utf-8?B?WTY2eDJDTTRYRlNHVHR6dGhUNjBEc0UvbUJXTGIzQ084bmRlRjlXSThuNDR5?=
 =?utf-8?B?Q0c3c3VHc1VIcmtmZ1p4eldyVURiQmY0OXVrMlExb3FCZER0eWVNcTBQcmdI?=
 =?utf-8?B?U05jSWlYLzJJdEhvK2ZnKy9SOXg1empJRHdSZTdEN0pyTkRDaGFteC9HaGJG?=
 =?utf-8?B?b2RBbW9OUTRQMjZ6OG9lQko5NUlaM1R2a2ZjYit2SDJNSlJtRG1GMVJSTDlC?=
 =?utf-8?B?UXJLZlZiV2JJdHJsZnNWOE9ZeUptMkZ6UlZoZm00TnhSeXNkODdOYkRlOXBn?=
 =?utf-8?B?V29QUW1LSnJpOTdzV0gzanJlK2RZYXp0ZjlLYWdCRTVVV1lRbysxQVdMdTAr?=
 =?utf-8?B?ejNlVWFPa2lqZml6UXp5RVZiVXgvNFRRd0RkOWxxZWozTFJsSW1zdjZFQjBM?=
 =?utf-8?B?UkFBQ2NwNE9MbThQMGV1MFU1Z3lMeE0zSnNRQ2dXUkdmbTdUQVZLT1FBQVJ6?=
 =?utf-8?B?OWxZOExIcHh2YkdwRG1OR2VHWWRiTVRUVERCM2ZFRE5HUWh4Tm52NU9zcndJ?=
 =?utf-8?B?VVRrVStxb0xVV0MvRnR5RmxzOHlYZVUvQjZPam9acWdraE9QdGJ2K0JIR3Qz?=
 =?utf-8?B?SncveGNKVHdmTzFBNjBJSis5WnY0QWtCcGtDVThuQXRaeDd6WEhNS3dNRUhH?=
 =?utf-8?B?NEpPVkxpOEg5dFpZdU5BeE1KNitHWjhFOVRmdWxVTmJlM3BVZWkzdDJQR2lC?=
 =?utf-8?B?MG95eDFiTG13R1JGUktpRGU5M3FYUlJvdEVpR2FyOG9uaTFQM1R1eTJuKzRT?=
 =?utf-8?B?S3lZcHRPY2RrK21oSm5ZK2tYRThNRGZLMVYzZWNMOVQ5THpIbFJ5SGdKbkY0?=
 =?utf-8?B?RDV3UTUraC9pbDRqMEFGbGFMakNlV29xL0ZPYndYc0RIY250NjlaMDVGMVBW?=
 =?utf-8?B?RjJmLzA0QU45SEppQS9jN0hBL3ZINlFvaitMWmlJS0JWSWRYaklabS9ZcGdi?=
 =?utf-8?B?M050UXBOcHFwMGhLa1R6eXo5azBkQzFHZW4wNzhJVnFaZzlTSDBKUy9YQ1dj?=
 =?utf-8?B?NUYyTmdzOXE4WHFKSE4yditXbDcxMFdMWEJoWXVhTmtRcjFReDROR2d5dU5T?=
 =?utf-8?B?RlRlUldvMkJscTFnc2FWSDVMQzUxaU8xdEZrTEd6TnpEckhJRTc3eHBidUsv?=
 =?utf-8?B?ZE1IQ05sVkRHd1l6STRBSGpqOU44SkVCWGM3R0RDeG1QdUVnYUpPM1ZTWHRn?=
 =?utf-8?Q?fylM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DB5PR02MB10213.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07f130ff-7fe6-4f0d-7dc5-08dbb829b765
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Sep 2023 09:29:11.2744
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1Cz8hIdd2T+6sv9YlNrpeYSgL5B0Jbw12u9u83kFTNV9+7CKUY0zKxdirk/9nQ6q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB7020
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Mon, 18 Sep 2023 09:29:23 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15077

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBiaXRiYWtlLWRldmVsQGxpc3Rz
Lm9wZW5lbWJlZGRlZC5vcmcgPGJpdGJha2UtZGV2ZWxAbGlzdHMub3BlbmVtYmVkZGVkLm9yZz4g
T24gQmVoYWxmIE9mIE1hdHRoaWFzIFNjaG5lbHRlDQo+IFNlbnQ6IGRlbiAxNyBzZXB0ZW1iZXIg
MjAyMyAxNDozMQ0KPiBUbzogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+
IFN1YmplY3Q6IFtiaXRiYWtlLWRldmVsXSBbUEFUQ0ggdjJdIGZldGNoMjogQWRkcyB2c2NvZGUg
ZGV2Y29udGFpbmVyIHN1cHBvcnQNCj4gDQo+IFZpc3VhbCBzdHVkaW8gY29kZSBpcyBpbmplY3Rp
bmcgYSBnaXQgY3JlZGVudGlhbCBoZWxwZXINCj4gaW50byBldmVyeSBkZXYgY29udGFpbmVyLiBU
aGlzIGhlbHBlciBpcyBmb3J3YXJkaW5nIHRoZSBnaXQgY3JlZGVudGlhbHMNCj4gZnJvbSB0aGUg
aG9zdCBpbnRvIHRoZSBjb250YWluZXIuDQo+IA0KPiBJbiBvcmRlciBmb3IgdGhpcyBoZWxwZXIg
dG8gd29yayB0aGUgUkVNT1RFX0NPTlRBSU5FUlNfSVBDDQo+IG5lZWRzIHRvIGJlIGF2YWlsYWJs
ZSBpbiB0aGUgZW52aXJvbm1lbnQgZm9yIGFsbCBnaXQgb3BlcmF0aW9ucw0KPiB0aGF0IHJlcXVp
cmUgYXV0aGVudGljYXRpb24uDQo+IA0KPiB2MjogQWRkZWQgc2lnbmVkLW9mZg0KDQpQYXRjaCBz
ZXQgY2hhbmdlIGluZm9ybWF0aW9uIGJlbG9uZ3MgYmVsb3cgdGhlIC0tLSBsaW5lIGJlbG93LiBP
dGhlcndpc2UgDQppdCB3aWxsIGJlIHBhcnQgb2YgdGhlIGFjdHVhbCBjb21taXQsIHdoaWNoIG5v
cm1hbGx5IGRvZXMgbm90IG1ha2UgYW55IA0Kc2Vuc2UuDQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6
IE1hdHRoaWFzIFNjaG5lbHRlIDxkZXZlbG9wQHNjaG5lbHRlLmRlPg0KPiAtLS0NCj4gIMKgbGli
L2JiL2ZldGNoMi9fX2luaXRfXy5weSB8IDEgKw0KPiAgwqAxIGZpbGUgY2hhbmdlZCwgMSBpbnNl
cnRpb24oKykNCj4gDQo+IGRpZmYgLS1naXQgYS9saWIvYmIvZmV0Y2gyL19faW5pdF9fLnB5IGIv
bGliL2JiL2ZldGNoMi9fX2luaXRfXy5weQ0KPiBpbmRleCA3NjVhZWRkNS4uZmZiMWE5MmIgMTAw
NjQ0DQo+IC0tLSBhL2xpYi9iYi9mZXRjaDIvX19pbml0X18ucHkNCj4gKysrIGIvbGliL2JiL2Zl
dGNoMi9fX2luaXRfXy5weQ0KPiBAQCAtODc0LDYgKzg3NCw3IEBAIEZFVENIX0VYUE9SVF9WQVJT
ID0gWydIT01FJywgJ1BBVEgnLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgICdBV1NfU0VDUkVUX0FDQ0VTU19LRVknLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdBV1NfREVGQVVMVF9SRUdJT04nLA0KPiAgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdHSVRfQ0FDSEVfUEFUSCcsDQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICdSRU1PVEVfQ09OVEFJ
TkVSU19JUEMnLA0KPiAgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICdTU0xfQ0VSVF9ESVInXQ0KPiANCj4gIMKgZGVmIGdldF9mZXRjaGVyX2Vudmlyb25tZW50KGQp
Og0KPiAtLQ0KPiAyLjQyLjANCg0KLy9QZXRlcg0KDQo=

