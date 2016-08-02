Return-Path: <zzs213@126.com>
Received: from m15-35.126.com (m15-35.126.com [220.181.15.35])
	by mail.openembedded.org (Postfix) with ESMTP id 6E6186AC37
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Aug 2016 14:29:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=WsMiO
	Zyvu2JxBFug+9oHF8t3zfoFEWWw0XvIrbjowIQ=; b=TAokln73cxZH3dg6nLwf8
	Ko55Ut3q2hkn019hBesZhJvSLXml1GjKUwfMbglSGwZLj1T5sJa08M+fVFbW8Rg5
	tiXmX0BnIdCY7G/4OWiCOIwnsys5iesGeyUmfpTUyG+tYuBsQ9CVVZR2jf0TdkMN
	w5P3lbJ5z+0ath4sWiJitw=
Received: from zzs213$126.com ( [171.212.168.97] ) by ajax-webmail-wmsvr35
	(Coremail) ; Tue, 2 Aug 2016 22:29:13 +0800 (CST)
X-Originating-IP: [171.212.168.97]
Date: Tue, 2 Aug 2016 22:29:13 +0800 (CST)
From: zzs <zzs213@126.com>
To: bitbake-devel@lists.openembedded.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
	20160420(83524.8626) Copyright (c) 2002-2016 www.mailtech.cn 126com
X-CM-CTRLDATA: 3yISqmZvb3Rlcl9odG09Mzg2OjU2
MIME-Version: 1.0
Message-ID: <1c7e8f51.d202.1564ba890a5.Coremail.zzs213@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: I8qowEBJlUE6rqBX475ZAA--.52417W
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiYBe5GVbdVzcTYgACsP
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Fri, 05 Aug 2016 08:46:08 +0000
Subject: howto build specific version package
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
X-List-Received-Date: Tue, 02 Aug 2016 14:29:21 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_232063_1598705058.1470148153508"

------=_Part_232063_1598705058.1470148153508
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SGVsbG8sIGV2ZXJ5b25lCgpJIGhhdmUgdHdvIHZlcnNpb24gLmJiIHJlY2lwZSwgc3lhIHRlc3Rf
MS4wLmJiIGFuZCB0ZXN0XzIuMC5iYi4KV2hlbiBidWlsZCB0aGUgYHRlc3RgIHBhY2thZ2UgIHVz
aW5nIHRoZSBmbG93d2luZyBjbWQ6CiAgICBiaXRiYWtlIHRlc3QKQWx3YXlzIDIuMCB3YXMgYnVp
bHQuCk15IHF1ZXN0aW9uIGlzOiBob3cgdG8gbGV0IGJpdGJha2UgdG8gYnVpbGQgdmVyc2lvbiAx
LjAgb2YgdGhlIHRlc3QgcGFja2FnZQo=

------=_Part_232063_1598705058.1470148153508
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXY+SGVsbG8sIGV2ZXJ5b25lPGJyPjxicj5JIGhhdmUgdHdv
IHZlcnNpb24gLmJiIHJlY2lwZSwgc3lhIHRlc3RfMS4wLmJiIGFuZCB0ZXN0XzIuMC5iYi48YnI+
V2hlbiBidWlsZCB0aGUgYHRlc3RgIHBhY2thZ2UmbmJzcDsgdXNpbmcgdGhlIGZsb3d3aW5nIGNt
ZDo8YnI+Jm5ic3A7Jm5ic3A7Jm5ic3A7IGJpdGJha2UgdGVzdDxicj5BbHdheXMgMi4wIHdhcyBi
dWlsdC48YnI+TXkgcXVlc3Rpb24gaXM6IGhvdyB0byBsZXQgYml0YmFrZSB0byBidWlsZCB2ZXJz
aW9uIDEuMCBvZiB0aGUgdGVzdCBwYWNrYWdlIDxicj48L2Rpdj48L2Rpdj48YnI+PGJyPjxzcGFu
IHRpdGxlPSJuZXRlYXNlZm9vdGVyIj48cD4mbmJzcDs8L3A+PC9zcGFuPg==

------=_Part_232063_1598705058.1470148153508--
