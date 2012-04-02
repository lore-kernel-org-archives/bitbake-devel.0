Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <shane.wang@intel.com>) id 1SEc9D-0007CW-6K
	for bitbake-devel@lists.openembedded.org;
	Mon, 02 Apr 2012 09:57:55 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga101.ch.intel.com with ESMTP; 02 Apr 2012 00:48:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="126010380"
Received: from azsmsx601.amr.corp.intel.com ([10.2.121.193])
	by azsmga001.ch.intel.com with ESMTP; 02 Apr 2012 00:48:46 -0700
Received: from shsmsx151.ccr.corp.intel.com (10.239.6.50) by
	azsmsx601.amr.corp.intel.com (10.2.121.193) with Microsoft SMTP Server
	(TLS) id 8.2.255.0; Mon, 2 Apr 2012 00:48:45 -0700
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.36]) by
	SHSMSX151.ccr.corp.intel.com ([169.254.3.91]) with mapi id
	14.01.0355.002; Mon, 2 Apr 2012 15:48:44 +0800
From: "Wang, Shane" <shane.wang@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 5/7] meta-yocto/local.conf.sample:
	change =	to ?= for BB_NUMBER_THREADS and PARALLEL_MAKE
Thread-Index: AQHNEA78NykbByosSkCLPJgk5PJz1ZaHKNOA
Date: Mon, 2 Apr 2012 07:48:43 +0000
Message-ID: <3AB6CE7F274E534CAFD089D127A8A1FC23B01292@SHSMSX102.ccr.corp.intel.com>
References: <cover.1333289684.git.shane.wang@intel.com>
	<b5bd8a01e7cdc03219fd8cabc62010283bc18fc2.1333289684.git.shane.wang@intel.com>
In-Reply-To: <b5bd8a01e7cdc03219fd8cabc62010283bc18fc2.1333289684.git.shane.wang@intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
MIME-Version: 1.0
Subject: Re: [PATCH 5/7] meta-yocto/local.conf.sample: change =	to ?= for BB_NUMBER_THREADS and PARALLEL_MAKE
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
X-List-Received-Date: Mon, 02 Apr 2012 07:57:55 -0000
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Sorry, this was sent to the wrong mail list. I am going to resend.

--
Shane

Shane Wang wrote on=A02012-04-01:

> In the current local.conf, BB_NUMBER_THREADS and PARALLEL_MAKE are
> assigned by '=3D', which overwrites the values set from the Hob. To avoid
> that, use '?=3D' instead.
>=20
> [Yocto #2210]
>=20
> Signed-off-by: Shane Wang <shane.wang@intel.com>
> ---
>  meta-yocto/conf/local.conf.sample |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
> diff --git a/meta-yocto/conf/local.conf.sample
> b/meta-yocto/conf/local.conf.sample index 38507e3..a4a8192 100644 ---
> a/meta-yocto/conf/local.conf.sample +++
> b/meta-yocto/conf/local.conf.sample @@ -17,12 +17,12 @@
>  # These two options control how much parallelism BitBake should use.
>  The first # option determines how many tasks bitbake should run in
>  parallel: #
> -#BB_NUMBER_THREADS =3D "4"
> +#BB_NUMBER_THREADS ?=3D "4"
>  # # The second option controls how many processes make should run in
>  parallel when # running compile tasks: #
> -#PARALLEL_MAKE =3D "-j 4"
> +#PARALLEL_MAKE ?=3D "-j 4"
 # # For a quad-core machine, BB_NUMBER_THREADS =3D "4", PARALLEL_MAKE =3D =
"-j
 4" would # be appropriate for example.



