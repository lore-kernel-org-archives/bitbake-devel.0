Return-Path: <belen.barros.pena@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by mail.openembedded.org (Postfix) with ESMTP id 9ADFD77065
	for <bitbake-devel@lists.openembedded.org>;
	Tue,  9 Aug 2016 10:50:45 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga101.fm.intel.com with ESMTP; 09 Aug 2016 03:50:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.28,494,1464678000"; d="scan'208";a="152921734"
Received: from irsmsx102.ger.corp.intel.com ([163.33.3.155])
	by fmsmga004.fm.intel.com with ESMTP; 09 Aug 2016 03:50:34 -0700
Received: from irsmsx110.ger.corp.intel.com ([169.254.15.113]) by
	IRSMSX102.ger.corp.intel.com ([169.254.2.123]) with mapi id
	14.03.0248.002; Tue, 9 Aug 2016 11:50:33 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: Olof Johansson <olof.johansson@axis.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH] BB_NO_NETWORK: Fallback to local
	source for git lsremote
Thread-Index: AQHR8ivZWTey4QICVECirBgn6C1LzA==
Date: Tue, 9 Aug 2016 10:50:32 +0000
Message-ID: <D3CF6434.82B02%belen.barros.pena@intel.com>
References: <1470645281559.73326@axis.com>
	<1470650127.8166.40.camel@linuxfoundation.org>
	<7a284480-47ae-674c-3073-5680e626f769@smile.fr>
	<C61ACEF2-94CC-4609-91F5-D9139A779926@gmail.com>
	<20160808163926.GO4674@axis.com>
	<5D5A3DA9-5197-492B-8A63-E28A882D99F0@gmail.com>
	<20160809093647.GP4674@axis.com>
In-Reply-To: <20160809093647.GP4674@axis.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.6.6.160626
x-originating-ip: [10.103.238.161]
MIME-Version: 1.0
Subject: Re: [PATCH] BB_NO_NETWORK: Fallback to local source for git lsremote
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
X-List-Received-Date: Tue, 09 Aug 2016 10:50:46 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <D030F748A01D63419CDF9A46AEEE8B05@intel.com>
Content-Transfer-Encoding: quoted-printable



On 09/08/2016 10:36, "bitbake-devel-bounces@lists.openembedded.org on
behalf of Olof Johansson" <bitbake-devel-bounces@lists.openembedded.org on
behalf of olof.johansson@axis.com> wrote:

>and unlike OE, we know a lot about our
>users/developers.

We actually know a thing or two about our users, but having worked on both
OE and commercial products I have learnt that the degree of variability in
the user base and the kind of constraints you can enforce upon them are
very different in both contexts.

To be fair, OE has made a significant investment on user-centered
approaches. Between other things, by accepting an interaction designer and
user researcher (yours truly) between its contributors, something pretty
much unheard of among FOSS projects making tools for software engineers.

Cheers

Bel=E9n


