Return-Path: <wuzhenyu@ustc.edu>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6A89E8181D
	for <webhook@archiver.kernel.org>; Tue, 26 Sep 2023 05:37:38 +0000 (UTC)
Received: from mail-m118111.qiye.163.com (mail-m118111.qiye.163.com [115.236.118.111])
 by mx.groups.io with SMTP id smtpd.web10.12533.1695706654619685194
 for <bitbake-devel@lists.openembedded.org>;
 Mon, 25 Sep 2023 22:37:35 -0700
Authentication-Results: mx.groups.io;
 dkim=none (message not signed); spf=pass (domain: ustc.edu, ip: 115.236.118.111, mailfrom: wuzhenyu@ustc.edu)
Received: from ustc.edu (localhost [127.0.0.1])
	by mail-m12743.qiye.163.com (Hmail) with ESMTP id 036627E0332;
	Tue, 26 Sep 2023 13:36:44 +0800 (CST)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Message-ID: <ADgAbwASGBcKbxctD6jRgaqX.1.1695706604007.Hmail.wuzhenyu@ustc.edu>
To: Richard Purdie <richard.purdie@linuxfoundation.org>, 
	bitbake-devel@lists.openembedded.org
Cc: michael.opdenacker@bootlin.com
Subject: =?UTF-8?B?UmU6IFtiaXRiYWtlLWRldmVsXSBTdXBwb3J0IHBhY2thZ2luZw==?=
X-Priority: 3
X-Mailer: HMail Webmail Server V2.0 Copyright (c) 2016-163.com
X-Originating-IP: 114.214.233.200
MIME-Version: 1.0
Received: from wuzhenyu@ustc.edu( [114.214.233.200) ] by ajax-webmail ( [127.0.0.1] ) ; Tue, 26 Sep 2023 13:36:44 +0800 (GMT+08:00)
From: =?UTF-8?B?5ZC05oyv5a6H?= <wuzhenyu@ustc.edu>
Date: Tue, 26 Sep 2023 13:36:44 +0800 (GMT+08:00)
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTB1JVh1JHx5IHUNITUlNT1UTARMWGhIXJBQOD1
	lXWRgSC1lBWUpKT1VJSk9VSUhIVUlLS1lXWRYaDxIVHRRZQVlPS0hVSkhDTEhKVUpLS1VLWQY+
X-HM-Tid: 0a8acffa8535b216kuuu18ab7f0c5a1
X-HM-MType: 1
X-HM-NTES-SC: AL0_4z5B86Wr4Tz9jdMF+bhXMW6NuPBB0r+GVJOnLUWRjuB87raS907Coyc1na
	e5RceMZFlUa6XMngDIxTyW3F/F6A43v9Y7N15HagS30UOZhYBVZ1oRpR/yAuatwlYk56106elPee
	vl1r1a7opKw7fZj0d8RKedxMio1GI+Bn+HrBU=
X-HM-Sender-Digest: e1kMHhlZQQ8JDh5XWRIfHhUPWUFZRzo*HDoZDDooPDkYMBkDGA8*TREp
	HBoKI1VKVUpNQk5MS01NS09NS0pVMxYaEhdVDA4BEx4VAg47DggPGFUeHw5FWVdZEgtZQVlKSk9V
	SUpPVUlISFVJS0tZV1kIAVlBSE5KSTcG
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 26 Sep 2023 05:37:38 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15126

SGV5LiBDYW4gW3RoaXMgbGFuZ3VhZ2Ugc2VydmVyXShodHRwczovL2dpdGh1Yi5jb20vRnJlZWQt
V3UvYml0YmFrZS1sYW5ndWFnZS1zZXJ2ZXIpIGJlIGhvc3RlZCBvbiBodHRwczovL2dpdGh1Yi5j
b20vb3BlbmVtYmVkZGVkID8KCjEuIEl0IGNhbiBpbXByb3ZlIHZpc2liaWxpdHkgdG8gbGV0IG1v
cmUgcGVvcGxlIGtub3cgdGhlbS4KMi4gR2V0IG1vcmUgYnVnIHJlcG9ydHMgdG8gaW1wcm92ZSB0
aGUgcHJvamVjdC4KMy4gSW5jcmVhc2UgYnVzIGZhY3Rvci4KCk9uIEZyaSwgSnVuIDIzLCAyMDIz
IGF0IDEwOjIxOjQ1QU0gKzAxMDAsIFJpY2hhcmQgUHVyZGllIHdyb3RlOgo+IE9uIEZyaSwgMjAy
My0wNi0yMyBhdCAxNzoxMyArMDgwMCwgV3UgWmhlbnl1IHdyb3RlOgo+ID4gSGksIEkgY3JlYXRl
IGEgbGFuZ3VhZ2Ugc2VydmVyIGZvciBiaXRiYWtlIGluIDxodHRwczovL2dpdGh1Yi5jb20vRnJl
ZWQtV3UvYml0YmFrZS1sYW5ndWFnZS1zZXJ2ZXI+Lgo+ID4gSXQgcmVhbGx5IG5lZWQgYml0YmFr
ZSBhcyBhIHB5dGhvbiBwYWNrYWdlIHRvIHByb3ZpZGUgdGhlIGZ1bGwgZnVuY3Rpb25zLgo+ID4g
Tm93IEkgaGF2ZSB0byB1c2UgPGh0dHBzOi8vYXVyLmFyY2hsaW51eC5vcmcvcGFja2FnZXMvcHl0
aG9uLWJpdGJha2U+IGFzIGEgZGVwZW5kZW5jeS4KPiA+IENhbiB5b3UgcmV0aGluayBhZ2FpbiBh
Ym91dCBwYWNrYWdpbmcgaXQgaW4gUFlQST8KPiAKPiBBIGxhbmd1YWdlIHNlcnZlciBzb3VuZHMg
cmVhbGx5IGludGVyZXN0aW5nIGFuZCBJJ2xsIGhhdmUgdG8gdGFrZSBhCj4gbG9vay4gSWYgd2Ug
YWRkIGl0IHRvIFBZUEksIHdobyBpcyBnb2luZyB0byBkZWFsIHdpdGggdGhlIHVzYWJpbGl0eQo+
IGlzc3VlcyBJIG1lbnRpb25lZCwgdGhlIGRvY3VtZW50YXRpb24gcHJvYmxlbSBhbmQgdGhlIHJl
c3VsdGluZyBzdXBwb3J0Cj4gd2hlcmUgcGVvcGxlIG1pc21hdGNoIGJpdGJha2UgdmVyc2lvbnM/
Cj4gCj4gVGhlcmUgYXJlIHNvbWUgc3BlY2lmaWMgaXNzdWVzIHdlJ2QgbmVlZCB0byBzb2x2ZSBp
ZiB3ZSB3ZXJlIHRvIHB1dAo+IGJpdGJha2Ugb24gUFlQSSBhbmQgSSdtIG5vdCBzZWVpbmcgYW55
IGhlbHAgb3Igc29sdXRpb25zIGJlaW5nIG9mZmVyZWQKPiB0byB0aGF0IDooLiBJJ20gYnVybmlu
ZyBvdXQgd2l0aCB0aGUgcHJvamVjdCBhcyB0aGluZ3Mgc3RhbmQsIEkgZG9uJ3QKPiByZWFsbHkg
d2FudCB0byBjcmVhdGUgbmV3IGlzc3Vlcy4KPiAKPiBDaGVlcnMsCj4gCj4gUmljaGFyZAo+IAo+
IAo+IAoKLS0gCkJlc3QgUmVnYXJkcwpXdSBaaGVueXUKCg0KDQo=

