Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SA02U-0000nT-HC
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 15:27:55 +0100
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2012 07:18:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="121096854"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 20 Mar 2012 07:17:48 -0700
Received: from azsmsx604.amr.corp.intel.com (10.2.161.34) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 20 Mar 2012 07:17:47 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx604.amr.corp.intel.com (10.2.161.34) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Tue, 20 Mar 2012 07:17:48 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Tue, 20 Mar 2012 22:17:45 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, Joshua Lock <josh@linux.intel.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 02/12] Hob: use HobNotebook to
	implement a notebook in build details page
Thread-Index: AQHNBir3u8y5qha/XESlHAi9eK2hx5ZzMbdwgAAKSmA=
Date: Tue, 20 Mar 2012 14:17:45 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23AF2652@SHSMSX102.ccr.corp.intel.com>
References: <8dafade95596191e9998acc05dcf7c34737d70c1.1331910234.git.shane.wang@intel.com>
	<8565670d713978a93a57a96c55b4815a144af3e5.1331910234.git.shane.wang@intel.com>
	<4F67C607.50806@linux.intel.com> 
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 02/12] Hob: use HobNotebook to implement a notebook in build details page
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.11
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/options/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.linuxtogo.org/pipermail/bitbake-devel>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>,
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Tue, 20 Mar 2012 14:27:55 -0000
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

aHR0cHM6Ly9idWd6aWxsYS55b2N0b3Byb2plY3Qub3JnL3Nob3dfYnVnLmNnaT9pZD0yMTQ0DQpm
b3IgdGhpcy4NCg0KLS0NClNoYW5lDQoNCldhbmcsIFNoYW5lIHdyb3RlIG9uwqAyMDEyLTAzLTIw
Og0KDQo+IEpvc2h1YSBMb2NrIHdyb3RlIG9uwqAyMDEyLTAzLTIwOg0KPiANCj4+IE9uIDE2LzAz
LzEyIDA4OjEwLCBTaGFuZSBXYW5nIHdyb3RlOg0KPj4+ICAgY2xhc3MgUnVubmluZ0J1aWxkTW9k
ZWwgKGd0ay5UcmVlU3RvcmUpOg0KPj4+IEBAIC00MCw2ICs0MSwzMiBAQCBjbGFzcyBSdW5uaW5n
QnVpbGRNb2RlbCAoZ3RrLlRyZWVTdG9yZSk6DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIGdvYmplY3QuVFlQRV9TVFJJTkcsDQo+Pj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIGdvYmplY3QuVFlQRV9JTlQpDQo+Pj4gKyAgICBkZWYgY29uZmlnX21vZGVs
X2ZpbHRlcihzZWxmLCBtb2RlbCwgaXQpOg0KPj4+ICsgICAgICAgIG1zZyA9IG1vZGVsLmdldChp
dCwgc2VsZi5DT0xfTUVTU0FHRSlbMF0NCj4+PiArICAgICAgICBpZiBtc2cgPT0gTm9uZSBvciB0
eXBlKG1zZykgIT0gc3RyOg0KPj4+ICsgICAgICAgICAgICByZXR1cm4gRmFsc2UNCj4+PiArICAg
ICAgICBpZiBtc2cuc3RhcnRzd2l0aCgiXG5PRSBCdWlsZCBDb25maWd1cmF0aW9uOlxuIik6DQo+
Pj4gKyAgICAgICAgICAgIHJldHVybiBUcnVlDQo+Pj4gKyAgICAgICAgcmV0dXJuIEZhbHNlDQo+
PiANCj4+IEkgdGhpbmsgSSBjb21tZW50ZWQgb24gdGhpcyBiZWZvcmUsIHRoaXMgc2VlbXMgbGlr
ZSBhIGhlYXZ5IHdheSB0bw0KPj4gYWNoaWV2ZSB0aGlzIGZ1bmN0aW9uYWxpdHkuIElzIHRoZXJl
IG5vdCBhbm90aGVyIHdheSB3ZSBjYW4gZGlzcGxheSB0aGUNCj4+IEJ1aWxkIENvbmZpZ3VyYXRp
b24gdG8gdGhlIHVzZXIgd2l0aG91dCBoYXZpbmcgdG8gZmlsdGVyIGV2ZXJ5IG1lc3NhZ2UNCj4+
IGVtaXR0ZWQ/DQo+IEkgYW0gZ29pbmcgdG8gc3VibWl0IGEgYnVnIGluIGJ1Z3ppbGxhIHRvIGFk
ZHJlc3MgaXQgbGF0ZXIsIHNpbmNlIHRoZSBzZXJpZXMgb2YNCj4gcGF0Y2hlcyBibG9jayBhIGxv
dCBvZiBwYXRjaCBzdWJtaXNzaW9ucy4NCj4gDQo+PiANCj4+IEZ1cnRoZXIsIGlmIHdlJ3JlIGdv
aW5nIHRvIGRpc3BsYXkgdGhpcyBpbmZvcm1hdGlvbiBpbiBhIHNlcGFyYXRlIHBhZ2UNCj4+IG9m
IHRoZSBub3RlYm9vayB3b3VsZCBpdCBub3QgbWFrZSBzZW5zZSB0byBub3Qgc2hvdyBpdCBpbiB0
aGUgYnVpbGQgbG9nDQo+PiBwYWdlPw0KPiBPSywgaWYgeW91IHdhbnQgSSBjYW4gcmVtb3ZlIGl0
LiBCdXQgSSBzdWdnZXN0IHRvIGtlZXAgaXQgYmVjYXVzZSBvZiB5b3VyDQo+IGFib3ZlIGNvbW1l
bnQuDQo+IFRoYXQgaXMgdGhlIGNvbmZpZ3VyYXRpb24gaW5mb3JtYXRpb24gaW4gQ29uZmlndXJh
dGlvbiBUYWIgY29tZXMgZnJvbQ0KPiBkaWZmZXJlbnQgc291cmNlcy4NCj4NCg0KDQo=


