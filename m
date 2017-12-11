Return-Path: <chaujohnthan@163.com>
X-Greylist: delayed 909 seconds by postgrey-1.34 at layers.openembedded.org;
	Mon, 11 Dec 2017 14:33:20 UTC
Received: from m13-9.163.com (m13-9.163.com [220.181.13.9])
	by mail.openembedded.org (Postfix) with ESMTP id 7563C78493
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 11 Dec 2017 14:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Date:From:Subject:MIME-Version:Message-ID; bh=7nC/3
	lv0mRRryMpCYEHdk24szD6IerRi1JONbY3YwXM=; b=as1+53+vsByWzwWZ8W2+D
	ZSIdEDgii+ioJeUWNimwSkgtyNPP/JWmvpkmm5LmMy8ttl51PiQj+NTv60s77HUO
	agtiNpuMqjnE3uDCSzcOo+twno0quecZySmy/YlzTQTfSYUbU5qy90szF0yDfE0d
	6gmsuAPBHB2swAmM5uC2PA=
Received: from chaujohnthan$163.com ( [223.73.1.49] ) by ajax-webmail-wmsvr9
	(Coremail) ; Mon, 11 Dec 2017 22:18:08 +0800 (CST)
X-Originating-IP: [223.73.1.49]
Date: Mon, 11 Dec 2017 22:18:08 +0800 (CST)
From: jc <chaujohnthan@163.com>
To: bitbake-devel@lists.openembedded.org
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
	20160729(86883.8884) Copyright (c) 2002-2017 www.mailtech.cn 163com
MIME-Version: 1.0
Message-ID: <d989f22.7b71.16045f0ab2a.Coremail.chaujohnthan@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: CcGowAA385Chky5aEFwTAA--.33185W
X-CM-SenderInfo: pfkd3yhrkq3xldq6il2tof0z/1tbiyB+rQVWBaJAnTwABs4
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Mailman-Approved-At: Sun, 17 Dec 2017 14:25:31 +0000
Subject: bitbake urllib usage is buggy
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
X-List-Received-Date: Mon, 11 Dec 2017 14:33:21 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_116116_365312724.1513001888554"

------=_Part_116116_365312724.1513001888554
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: base64

SSBoYXZlIGRvd25sb2FkZWQgYSBsb3Qgb2YgYml0YmFrZSB0YXJiYWxscywgYnV0IG5vbmUgd29y
a2VkIG91dCBvZgpUaHIgYm94LCBhZnRlciBzZXJ2ZXJhbCB0d2lzdHMsIGkgY2FtZSB0byB1cmxs
aWIgaW1wb3J0IHByb2JsZW0uCgoKCgpJIGhhdmUgY29tcGlsZWQgcHl0aG9uIDIuNy41LCAzLjQu
MCBhcyB3ZWxsLCBidXQgYml0YmFrZSBzZWVtcyBtaXhlZCBwMyBwMiB1cC4KU29tZXdoZXJlIGl0
IHNheXMgcHkyIG5lZWRlZCwgb3RoZXJzIG5lZWQgcHkzLgoKCkhvdyBjb21lIHRoaXMgcGFja2Fn
ZSBiZWVuIHVzZWQgZm9yIHF1aXRlIGEgd2hpbGUsIHN0aWxsIHNvIGJ1Z2d5PwoKCkkgc3RpY2sg
dG8gdGhpcyBiaXRiYWtlLCBiY3ogdGhlc2UgYXJtIGxpbnV4IHBhY2thZ2UgbWFuYWdlbWVudCBh
cmUgbm90IGEgdHJpdmFsIHRhc2ssCkJ1dCBub3csIGkgdGhpbmssIGlmIHRoaXMgdG9vbCBpcyBi
dXVneSwgdGhlIG90aGVyIHBhY2thZ2VzIG9mIHRvbnMgd291bGQgZW5kIHVwCkJ1Z2d5IHRvby4g
V2hhdCBzaG91bGQgaSBkbz8KCgpJIG5lZWQgaGVscCwgdG8gZ2V0IGEgd29ya2FibGUgYml0YmFr
ZSBmb3Igc3RhbmRhcmRpemVkIHB5MiBvciBweTMsCgoKCgpUaWEKSm9obnRoYW4gY2hhdQoKCgoK
UHMsIGkgd29yayBvbiBzbGFja3dhcmUgMTIgeDY0LCBoYXZlIGEgaW14NnEgcXQ1IHByb2plY3Qg
dW5kZXJ0YWtpbmcu

------=_Part_116116_365312724.1513001888554
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: base64

PGRpdiBzdHlsZT0ibGluZS1oZWlnaHQ6MS43O2NvbG9yOiMwMDAwMDA7Zm9udC1zaXplOjE0cHg7
Zm9udC1mYW1pbHk6QXJpYWwiPjxkaXY+SSBoYXZlIGRvd25sb2FkZWQgYSBsb3Qgb2YgYml0YmFr
ZSB0YXJiYWxscywgYnV0IG5vbmUgd29ya2VkIG91dCBvZjwvZGl2PjxkaXY+VGhyIGJveCwgYWZ0
ZXIgc2VydmVyYWwgdHdpc3RzLCBpIGNhbWUgdG8gdXJsbGliIGltcG9ydCBwcm9ibGVtLjwvZGl2
PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+SSBoYXZlIGNvbXBpbGVkIHB5dGhv
biAyLjcuNSwgMy40LjAgYXMgd2VsbCwgYnV0IGJpdGJha2Ugc2VlbXMgbWl4ZWQgcDMgcDIgdXAu
PC9kaXY+PGRpdj5Tb21ld2hlcmUgaXQgc2F5cyBweTIgbmVlZGVkLCBvdGhlcnMgbmVlZCBweTMu
PC9kaXY+PGRpdj48YnI+PC9kaXY+PGRpdj5Ib3cgY29tZSB0aGlzIHBhY2thZ2UgYmVlbiB1c2Vk
IGZvciBxdWl0ZSBhIHdoaWxlLCBzdGlsbCBzbyBidWdneT88L2Rpdj48ZGl2Pjxicj48L2Rpdj48
ZGl2Pkkgc3RpY2sgdG8gdGhpcyBiaXRiYWtlLCBiY3ogdGhlc2UgYXJtIGxpbnV4IHBhY2thZ2Ug
bWFuYWdlbWVudCBhcmUgbm90IGEgdHJpdmFsIHRhc2ssPC9kaXY+PGRpdj5CdXQgbm93LCBpIHRo
aW5rLCBpZiB0aGlzIHRvb2wgaXMgYnV1Z3ksIHRoZSBvdGhlciBwYWNrYWdlcyBvZiB0b25zIHdv
dWxkIGVuZCB1cDwvZGl2PjxkaXY+QnVnZ3kgdG9vLiBXaGF0IHNob3VsZCBpIGRvPzwvZGl2Pjxk
aXY+PGJyPjwvZGl2PjxkaXY+SSBuZWVkIGhlbHAsIHRvIGdldCBhIHdvcmthYmxlIGJpdGJha2Ug
Zm9yIHN0YW5kYXJkaXplZCBweTIgb3IgcHkzLDwvZGl2PjxkaXY+PGJyPjwvZGl2PjxkaXY+PGJy
PjwvZGl2PjxkaXY+VGlhPC9kaXY+PGRpdj5Kb2hudGhhbiBjaGF1PC9kaXY+PGRpdj48YnI+PC9k
aXY+PGRpdj48YnI+PC9kaXY+PGRpdj5QcywgaSB3b3JrIG9uIHNsYWNrd2FyZSAxMiB4NjQsIGhh
dmUgYSBpbXg2cSBxdDUgcHJvamVjdCB1bmRlcnRha2luZy48L2Rpdj48L2Rpdj4=

------=_Part_116116_365312724.1513001888554--
