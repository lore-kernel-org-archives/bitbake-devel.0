Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
	by mail.openembedded.org (Postfix) with ESMTP id 2814E77C3B
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 12 Apr 2017 10:07:53 +0000 (UTC)
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
	by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	12 Apr 2017 03:07:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.37,190,1488873600"; d="scan'208";a="247644397"
Received: from lheah-mobl1.gar.corp.intel.com (HELO
	peggleto-mobl.ger.corp.intel.com) ([10.255.133.64])
	by fmsmga004.fm.intel.com with ESMTP; 12 Apr 2017 03:07:51 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Zhixiong Chi <zhixiong.chi@windriver.com>
Date: Wed, 12 Apr 2017 22:07:50 +1200
Message-ID: <3838289.2vYOkdbIYi@peggleto-mobl.ger.corp.intel.com>
Organization: Intel Corporation
In-Reply-To: <58ED9EA4.8020806@windriver.com>
References: <1491816164-18274-1-git-send-email-zhixiong.chi@windriver.com>
	<1491922037.12091.20.camel@linuxfoundation.org>
	<58ED9EA4.8020806@windriver.com>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: bitbake-layers: add signal hander to avoid exception
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
X-List-Received-Date: Wed, 12 Apr 2017 10:07:55 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 12 April 2017 3:27:32 PM NZST Zhixiong Chi wrote:
> On 2017=E5=B9=B404=E6=9C=8811=E6=97=A5 22:47, Richard Purdie wrote:
> > I discussed this with Paul and we
> > think other bitbake tools may also have this issue. We wondered if it
> > was possible to do something more centrally in bitbake, and/or fix the
> > other tools at the same time.
> >=20
> > Any thoughts on that?
>=20
> I agree with this, unfortunately out testing team haven't met this issue
> in other bitbake tools yet.

=46YI bitbake -e | less and then quit will trigger it with bitbake itself.

Cheers,
Paul

=2D-=20

Paul Eggleton
Intel Open Source Technology Centre

