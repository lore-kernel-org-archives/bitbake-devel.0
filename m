Return-Path: <peter.kjellerstedt@axis.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85914C433F5
	for <webhook@archiver.kernel.org>; Fri, 21 Jan 2022 15:36:50 +0000 (UTC)
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by mx.groups.io with SMTP id smtpd.web08.13278.1642779408892974569
 for <bitbake-devel@lists.openembedded.org>;
 Fri, 21 Jan 2022 07:36:49 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@axis.com header.s=axis-central1 header.b=m0jOjgYP;
 spf=pass (domain: axis.com, ip: 195.60.68.18,
 mailfrom: peter.kjellerstedt@axis.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1642779409;
  x=1674315409;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HDkaLs3syY1BaH7W5jR7/dKX1OJ09tXFz8NzeB5T3RA=;
  b=m0jOjgYP/A0ztt2A6Kqw5IDss3qDhjl3KK3B/3nMJrSvTEuiPxO0xaXE
   qZjz5v1szW12xEhGXFDNqch7JNM9Dq91Ld3Jjg4YfEjrzl+6GDFXtFwuG
   OsEuIahRw8B5t1hV/eo24sV9/l1RffXd6pkMZRKh4H5ey5tpISiz6qL49
   J9wJil8yi5iBZLky1+qScq5MmFL7qWQNUVrlpcdt0MloTknO8RoL/Mqej
   xujUxjxm1ddl3EljbJTLV/ubWHJwRYliR6lh5VExqXiGXe5523YX4Z/Cy
   +K3j9PfBI0srZbgH4GC3NTQyI8ZyfNXun/r6uOpLc5VU/EReNjkj4jyti
   A==;
From: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
To: Robert Yang <liezhi.yang@windriver.com>,
	"bitbake-devel@lists.openembedded.org" <bitbake-devel@lists.openembedded.org>
CC: "quaresma.jose@gmail.com" <quaresma.jose@gmail.com>
Subject: RE: [bitbake-devel] [PATCH 1/1] bitbake-worker: Check BB_TASK_NETWORK
 before disable network for task
Thread-Topic: [bitbake-devel] [PATCH 1/1] bitbake-worker: Check
 BB_TASK_NETWORK before disable network for task
Thread-Index: AQHYDc8shCHXyO6szEiPlZDWwnt6pKxr503AgADWfgCAAMj10A==
Date: Fri, 21 Jan 2022 15:36:44 +0000
Message-ID: <276b4301dac5442cae7a411c58f2db68@axis.com>
References: <cover.1642663574.git.liezhi.yang@windriver.com>
 <75af98ed9992aad08e6fadc64d1985a165529828.1642663574.git.liezhi.yang@windriver.com>
 <db841326fc6647919a2ee07a82693e30@axis.com>
 <1ee69861-28f1-dbd6-b26c-5f72894b01e4@windriver.com>
In-Reply-To: <1ee69861-28f1-dbd6-b26c-5f72894b01e4@windriver.com>
Accept-Language: en-US, sv-SE
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.0.5.60]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Fri, 21 Jan 2022 15:36:50 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/13270

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBSb2JlcnQgWWFuZyA8bGllemhp
LnlhbmdAd2luZHJpdmVyLmNvbT4NCj4gU2VudDogZGVuIDIxIGphbnVhcmkgMjAyMiAwNDoxNQ0K
PiBUbzogUGV0ZXIgS2plbGxlcnN0ZWR0IDxwZXRlci5ramVsbGVyc3RlZHRAYXhpcy5jb20+OyBi
aXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+IENjOiBxdWFyZXNtYS5q
b3NlQGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBSZTogW2JpdGJha2UtZGV2ZWxdIFtQQVRDSCAxLzFd
IGJpdGJha2Utd29ya2VyOiBDaGVjaw0KPiBCQl9UQVNLX05FVFdPUksgYmVmb3JlIGRpc2FibGUg
bmV0d29yayBmb3IgdGFzaw0KPiANCj4gSGkgUGV0ZXIsDQo+IA0KPiBPbiAxLzIwLzIyIDk6NTAg
UE0sIFBldGVyIEtqZWxsZXJzdGVkdCB3cm90ZToNCj4gPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdl
LS0tLS0NCj4gPj4gRnJvbTogYml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnIDxi
aXRiYWtlLQ0KPiBkZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnPiBPbiBCZWhhbGYgT2YgUm9i
ZXJ0IFlhbmcNCj4gPj4gU2VudDogZGVuIDIwIGphbnVhcmkgMjAyMiAwODoyNw0KPiA+PiBUbzog
Yml0YmFrZS1kZXZlbEBsaXN0cy5vcGVuZW1iZWRkZWQub3JnDQo+ID4+IENjOiBxdWFyZXNtYS5q
b3NlQGdtYWlsLmNvbQ0KPiA+PiBTdWJqZWN0OiBbYml0YmFrZS1kZXZlbF0gW1BBVENIIDEvMV0g
Yml0YmFrZS13b3JrZXI6IENoZWNrDQo+IEJCX1RBU0tfTkVUV09SSyBiZWZvcmUgZGlzYWJsZSBu
ZXR3b3JrIGZvciB0YXNrDQo+ID4+DQo+ID4+IFRoZSBOSVMgdXNlciBjYW4ndCB3b3JrIHdoZW4g
dGFzaydzIG5ldHdvcmsgaXMgZGlzYWJsZWQsIHNvIGNoZWNrDQo+ID4+IEJCX1RBU0tfTkVUV09S
SyBiZWZvcmUgZGlzYWJsZSBpdCwgdGhlIGNvbmYgZmlsZXMgY2FuIHNldA0KPiBCQl9UQVNLX05F
VFdPUksuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IFJvYmVydCBZYW5nIDxsaWV6aGkueWFu
Z0B3aW5kcml2ZXIuY29tPg0KPiA+PiAtLS0NCj4gPj4gICBiaXRiYWtlL2Jpbi9iaXRiYWtlLXdv
cmtlciB8IDMgKystDQo+ID4+ICAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKSwgMSBk
ZWxldGlvbigtKQ0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvYml0YmFrZS9iaW4vYml0YmFrZS13
b3JrZXIgYi9iaXRiYWtlL2Jpbi9iaXRiYWtlLXdvcmtlcg0KPiA+PiBpbmRleCAzYWFmM2MyNDQ0
Yi4uM2Q3YTc4MWQzNWMgMTAwNzU1DQo+ID4+IC0tLSBhL2JpdGJha2UvYmluL2JpdGJha2Utd29y
a2VyDQo+ID4+ICsrKyBiL2JpdGJha2UvYmluL2JpdGJha2Utd29ya2VyDQo+ID4+IEBAIC0yNjEs
NyArMjYxLDggQEAgZGVmIGZvcmtfb2ZmX3Rhc2soY2ZnLCBkYXRhLCBkYXRhYnVpbGRlciwNCj4g
d29ya2VyZGF0YSwNCj4gPj4gZm4sIHRhc2ssIHRhc2tuYW1lLCB0YXNraGENCj4gPj4NCj4gPj4g
ICAgICAgICAgICAgICAgICAgYmIudXRpbHMuc2V0X3Byb2Nlc3NfbmFtZSgiJXM6JXMiICUNCj4g
KHRoZV9kYXRhLmdldFZhcigiUE4iKSwgdGFza25hbWUucmVwbGFjZSgiZG9fIiwgIiIpKSkNCj4g
Pj4NCj4gPj4gLSAgICAgICAgICAgICAgICBpZiBub3QgdGhlX2RhdGEuZ2V0VmFyRmxhZyh0YXNr
bmFtZSwgJ25ldHdvcmsnLA0KPiBGYWxzZSk6DQo+ID4+ICsgICAgICAgICAgICAgICAgYmJfdGFz
a19uZXR3b3JrID0NCj4gYmIudXRpbHMudG9fYm9vbGVhbih0aGVfZGF0YS5nZXRWYXIoJ0JCX1RB
U0tfTkVUV09SSycpLCBGYWxzZSkNCj4gPg0KPiA+IFdoeSB1c2UgRmFsc2UgdG8gZ2V0VmFyKCkg
YWJvdmU/DQo+IA0KPiBUaGUgRmFsc2UgaXMgZm9yIGJiLnV0aWxzLnRvX2Jvb2xlYW4oKSwgbm90
IGdldFZhcigpLCB0aGUgZ2V0VmFyIGhhcyBvbmx5DQo+IG9uZSBhcmd1bWVudDoNCj4gDQo+IHRo
ZV9kYXRhLmdldFZhcignQkJfVEFTS19ORVRXT1JLJykNCg0KRHVoLCBvZiBjb3Vyc2UuIEkgZ3Vl
c3MgSSBuZWVkIG5ldyBnbGFzc2VzLi4uDQoNCj4gPg0KPiA+PiArICAgICAgICAgICAgICAgIGlm
IG5vdCAoYmJfdGFza19uZXR3b3JrIG9yDQo+IHRoZV9kYXRhLmdldFZhckZsYWcodGFza25hbWUs
ICduZXR3b3JrJywgRmFsc2UpKToNCj4gPg0KPiA+IEkgY2FuJ3Qgc3BlYWsgZm9yIG90aGVycywg
YnV0IEkgZmluZCAibm90IChmb28gb3IgYmFyKSIgYSBsb3QgaGFyZGVyIHRvDQo+ID4gcGFyc2Ug
dGhhbiAibm90IGZvbyBhbmQgbm90IGJhciIuDQo+IA0KPiBUZWNobmljYWxseSwgdGhlICJub3Qg
KGZvbyBvciBiYXIpIiBpcyBzbGlnaHRseSBmYXN0ZXIgdGhhbiAibm90IGZvbyBhbmQNCj4gbm90
IGJhciIgc2luY2UgdGhlIGxhdHRlciBvbmUgcmVxdWlyZXMgbW9yZSBsb2dpY2FsIGV2YWx1YXRl
cy4NCg0KU29tZWhvdywgSSB0aGluayB5b3Ugd2lsbCBmaW5kIGl0IGhhcmQgdG8gYWN0dWFsbHkg
bWVhc3VyZSB0aGF0IHRpbWUgDQpkaWZmZXJlbmNlLi4uIDspIEkgdHJpZWQsIGFuZCBpbiBteSB0
ZXN0aW5nIHRoZSB0aW1lIHRvIGV4ZWN1dGUgZWl0aGVyIA0Kc3RhdGVtZW50IHdhcyAwLjA3LTAu
MTIgzrxzLCBpLmUuLCBpdCB3YXMgaW1wb3NzaWJsZSB0byBkZWNsYXJlIGVpdGhlciANCmFzIGZh
c3RlciB0aGFuIHRoZSBvdGhlci4NCg0KPiAvLyBSb2JlcnQNCj4gDQo+ID4NCj4gPj4gICAgICAg
ICAgICAgICAgICAgICAgIGxvZ2dlci5kZWJ1ZygiQXR0ZW1wdGluZyB0byBkaXNhYmxlIG5ldHdv
cmsiKQ0KPiA+PiAgICAgICAgICAgICAgICAgICAgICAgYmIudXRpbHMuZGlzYWJsZV9uZXR3b3Jr
KHVpZCwgZ2lkKQ0KPiA+Pg0KPiA+PiAtLQ0KPiA+PiAyLjMxLjENCj4gPg0KPiA+IC8vUGV0ZXIN
Cg0KLy9QZXRlcg0KDQoNCg==

