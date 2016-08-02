Return-Path: <zzs213@126.com>
Received: from m15-35.126.com (m15-35.126.com [220.181.15.35])
	by mail.openembedded.org (Postfix) with ESMTP id 4A2F16AC37
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  2 Aug 2016 14:34:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=Kzns0
	PyrDJ0/58Hiod4lxnEfDMTT8/GuPxPSlP1Pjoo=; b=BJxBNBZWLzSRjzuJe+iLb
	wxKdr9GAetpV2eW43j74mEPHqt8XMdtgQV+jWbcRKXCV2iiea14/wT5PhswYLIo0
	kiGfOc+eloOHZUcal8+PX7ryCdBghB6zekNQYlrE8QvFO3bMAuER9XLjD5nE9Stw
	9cEAV5Z7BbV/aI9Fms5Ap8=
Received: from zzs213$126.com ( [171.212.168.97] ) by ajax-webmail-wmsvr35
	(Coremail) ; Tue, 2 Aug 2016 22:34:24 +0800 (CST)
X-Originating-IP: [171.212.168.97]
Date: Tue, 2 Aug 2016 22:34:24 +0800 (CST)
From: zzs  <zzs213@126.com>
To: bitbake-devel@lists.openembedded.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
	20160420(83524.8626) Copyright (c) 2002-2016 www.mailtech.cn 126com
MIME-Version: 1.0
Message-ID: <360daea.d273.1564bad5108.Coremail.zzs213@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: I8qowEAZfkJwr6BXhb9ZAA--.51311W
X-CM-SenderInfo: x22vjiat6rjloofrz/1tbiLQq5GVc1ookviwABsr
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
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
X-List-Received-Date: Tue, 02 Aug 2016 14:34:33 -0000
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8

CgpIZWxsbywgZXZlcnlvbmUKCkkgaGF2ZSB0d28gdmVyc2lvbiAuYmIgcmVjaXBlLCBzeWEgdGVz
dF8xLjAuYmIgYW5kIHRlc3RfMi4wLmJiLgpXaGVuIGJ1aWxkIHRoZSBgdGVzdGAgcGFja2FnZcKg
IHVzaW5nIHRoZSBmbG93d2luZyBjbWQ6CsKgwqDCoCBiaXRiYWtlIHRlc3QKQWx3YXlzIDIuMCB3
YXMgYnVpbHQuCk15IHF1ZXN0aW9uIGlzOiBob3cgdG8gbGV0IGJpdGJha2UgdG8gYnVpbGQgdmVy
c2lvbiAxLjAgb2YgdGhlIHRlc3QgcGFja2FnZSAKCgoKwqA=

