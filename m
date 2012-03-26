Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <belen.barros.pena@intel.com>) id 1SCE2L-0003Vz-6o
	for bitbake-devel@lists.openembedded.org;
	Mon, 26 Mar 2012 19:48:57 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
	by azsmga102.ch.intel.com with ESMTP; 26 Mar 2012 10:39:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="123422454"
Received: from irsmsx103.ger.corp.intel.com ([163.33.3.157])
	by azsmga001.ch.intel.com with ESMTP; 26 Mar 2012 10:39:52 -0700
Received: from irsmsx151.ger.corp.intel.com (163.33.192.59) by
	IRSMSX103.ger.corp.intel.com (163.33.3.157) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Mon, 26 Mar 2012 18:37:35 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.70]) by
	IRSMSX151.ger.corp.intel.com ([169.254.4.127]) with mapi id
	14.01.0355.002; Mon, 26 Mar 2012 18:38:08 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>, Joshua Lock <josh@linux.intel.com>, 
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 06/12] Hob: allow users to setup the
	proxies
Thread-Index: AQHNC3c1zH/W141EIU6XY5hehHPJ/Q==
Date: Mon, 26 Mar 2012 17:38:08 +0000
Message-ID: <CB96665A.B344%belen.barros.pena@intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23AF253A@SHSMSX102.ccr.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [10.254.193.216]
MIME-Version: 1.0
Cc: Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 06/12] Hob: allow users to setup the proxies
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
X-List-Received-Date: Mon, 26 Mar 2012 17:48:57 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <26FDD542474B6C418E249760C74FDF90@intel.com>
Content-Transfer-Encoding: quoted-printable

Hi all,

Sorry for the delay in commenting on this.

I've checked our discussions about the proxy functionality, and it looks
like we never reached an agreement on how to implement this feature. It
was suggested to configure the proxy through sites.conf, and then Scott
Garman replied pointing out that the "the proxy situation is a mess under
Linux. This is likely to be a non-trivial problem
(http://www.yoctoproject.org/blogs/sgarman/2011/proxy-problem)". After
that, the discussion died out.

We could review the implementation and provide some suggestions. Would
that be useful?

Cheers

Belen=20

On 20/03/2012 13:27, "Wang, Shane" <shane.wang@intel.com> wrote:

>Joshua Lock wrote on 2012-03-20:
>
>>=20
>>=20
>> On 16/03/12 08:10, Shane Wang wrote:
>>> This patch is to set os.environ to allow users to set the environment
>> variables for http_proxy, https_proxy and ftp_proxy.
>>=20
>> I think we need to be careful about implementing this functionality, so
>> I have two suggestions
>> 1) As far as I can tell the proxy settings will not be remembered
>> between runs of the Hob, I think they probably should be.
>Yes.
>
>> 2) If the user already has some or all of the proxy settings set in
>> their environment we should probably detect those and display them
>> appropriately in the GUI.
>OK, will investigate and have a try.
>
>>=20
>> Are their any design documents for this dialogue?
>No.
>
>>=20
>> Cheers,
>> Joshua
>_______________________________________________
>bitbake-devel mailing list
>bitbake-devel@lists.openembedded.org
>http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



