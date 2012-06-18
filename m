Received: from mail-ey0-f175.google.com ([209.85.215.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <raj.khem@gmail.com>) id 1SgjM6-0001V5-Ew
	for bitbake-devel@lists.openembedded.org;
	Mon, 18 Jun 2012 23:19:26 +0200
Received: by eaal1 with SMTP id l1so1762177eaa.6
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 18 Jun 2012 14:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20120113;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc:content-type:content-transfer-encoding;
	bh=wz1PbigoZiHLZ4HKy1bNxzhQb8P+jpobBhZugeRw4Yo=;
	b=ilDV+Qb7uh4kpuG8eZF4o+wLDpsxu0xpQW7QDR+8ubfUAUymXUvvBZuhRdOg2y0EE9
	BAms+xvTp7ZIIHiK5I7YyMkcUtNj/xP+ZJZqHDAG6TM0jOIGQpeej9Xv1Rn55zPRVWrl
	0F/n1H8weQqjgu6nLMR15z4EiLX3K5Yyz2kML7zINSLLiU9HQTUOTY1jiX9xYCmQ7S9I
	p0ztjeYlzrckjhJSk0Igmb+2fJjSMdWhFDh5rHNEnOuZzRFFGxPOshqsB0QPnOAVN5SY
	0NlbSM0hob4wcJBji6cZFJ8/xyu4UPY6g/DBMgj+Yqoe7u2yOJ0BR1eG8L2LW6tC674X
	+dMA==
Received: by 10.14.188.140 with SMTP id a12mr3674094een.25.1340053723597; Mon,
	18 Jun 2012 14:08:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.14.188.11 with HTTP; Mon, 18 Jun 2012 14:08:13 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1206181608120.22003@oneiric>
References: <alpine.DEB.2.02.1206181608120.22003@oneiric>
From: Khem Raj <raj.khem@gmail.com>
Date: Mon, 18 Jun 2012 14:08:13 -0700
Message-ID: <CAMKF1sqTiss0-CgVj5U=uvkUcuhs0o+fA+n-GbOCi8VunA+qGw@mail.gmail.com>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: is there a bitbake command to *just* fetch all necessary packages?
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
X-List-Received-Date: Mon, 18 Jun 2012 21:19:26 -0000
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64

T24gTW9uLCBKdW4gMTgsIDIwMTIgYXQgMToxMCBQTSwgUm9iZXJ0IFAuIEouIERheSA8cnBqZGF5
QGNyYXNoY291cnNlLmNhPiB3cm90ZToKPgo+IMKgcGVyaGFwcyBpJ20ganVzdCBtaXNyZWFkaW5n
IHRoZSBkb2NzLCBidXQgaXMgdGhlcmUgYSBiaXRiYWtlCj4gaW5jYW50YXRpb24gdGhhdCBkb2Vz
ICpub3RoaW5nKiBtb3JlIHRoYW4gZmV0Y2ggdGhlIHBhY2thZ2VzIG5lZWRlZAo+IGZvciBhIHRh
cmdldCBpbWFnZT8KPgo+IMKgaWYgaSB1c2UgImJpdGJha2UgLWMgZmV0Y2hhbGwiLCB0aGUgcmVz
dWx0IGlzIG5vdCBqdXN0IHRvIGZldGNoIHRoZQo+IHNvdXJjZSwgYnV0IHRvIHVubG9hZCBhbmQg
cGF0Y2ggaXQgYXMgd2VsbC4KCmhtbW0gSSB0aG91Z2h0IGl0IGRpZCBqdXN0IHdoYXQgaXQgc2F5
cyAnZmV0Y2ggYWxsJyBidXQgYXMgeW91IHNheSBpdApzZWVtcyB0byBkbyBtb3JlIGhtbSBJIGFt
IG5vdCBzdXJlIGlmIGl0cyBpbnRlbmRlZCBiZWhhdmlvcgoKwqBpIGRvbid0IHdhbnQgdGhhdCwg
aSB3YW50Cj4gd2hhdGV2ZXIgdGhlIG1hZ2ljIGlzIHRvIGp1c3QgKmZldGNoKiBhbmQgbGVhdmUg
aXQgYXQgdGhhdC4gwqBvciBpcwo+IHRoYXQgc2ltcGx5IG5vdCBwb3NzaWJsZT8KPgo+IHJkYXkK
Pgo+IC0tCj4KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiBSb2JlcnQgUC4gSi4gRGF5IMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE90dGF3YSwgT250YXJpbywgQ0FO
QURBCj4gwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBodHRwOi8vY3Jhc2hjb3Vy
c2UuY2EKPgo+IFR3aXR0ZXI6IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIGh0dHA6Ly90d2l0dGVyLmNvbS9ycGpkYXkKPiBMaW5rZWRJbjog
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaHR0cDovL2NhLmxp
bmtlZGluLmNvbS9pbi9ycGpkYXkKPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPgo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gYml0YmFrZS1kZXZlbCBtYWlsaW5n
IGxpc3QKPiBiaXRiYWtlLWRldmVsQGxpc3RzLm9wZW5lbWJlZGRlZC5vcmcKPiBodHRwOi8vbGlz
dHMubGludXh0b2dvLm9yZy9jZ2ktYmluL21haWxtYW4vbGlzdGluZm8vYml0YmFrZS1kZXZlbAo=


