Received: from mga14.intel.com ([143.182.124.37])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <belen.barros.pena@intel.com>) id 1SFS30-0001n2-7D
	for bitbake-devel@lists.openembedded.org;
	Wed, 04 Apr 2012 17:22:58 +0200
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga102.ch.intel.com with ESMTP; 04 Apr 2012 08:13:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="85239261"
Received: from irsmsx101.ger.corp.intel.com ([163.33.3.153])
	by AZSMGA002.ch.intel.com with ESMTP; 04 Apr 2012 08:13:45 -0700
Received: from irsmsx104.ger.corp.intel.com (163.33.3.159) by
	IRSMSX101.ger.corp.intel.com (163.33.3.153) with Microsoft SMTP Server
	(TLS) id 14.1.355.2; Wed, 4 Apr 2012 16:13:21 +0100
Received: from irsmsx101.ger.corp.intel.com ([169.254.1.40]) by
	IRSMSX104.ger.corp.intel.com ([169.254.5.200]) with mapi id
	14.01.0355.002; Wed, 4 Apr 2012 16:13:21 +0100
From: "Barros Pena, Belen" <belen.barros.pena@intel.com>
To: "Wang, Shane" <shane.wang@intel.com>,
	"bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Thread-Topic: [bitbake-devel] [PATCH 2/4] Hob: log for Hob and allow users
	to show logs after successful build
Thread-Index: AQHNEnV4voAkhQa60EmERg4ktXKAFw==
Date: Wed, 4 Apr 2012 15:13:20 +0000
Message-ID: <CBA22274.C4EE%belen.barros.pena@intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23B11E92@SHSMSX102.ccr.corp.intel.com>
Accept-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.14.0.111121
x-originating-ip: [10.254.112.116]
MIME-Version: 1.0
Cc: Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 2/4] Hob: log for Hob and allow users to show logs after successful build
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
X-List-Received-Date: Wed, 04 Apr 2012 15:22:58 -0000
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-ID: <857F17DD05ECC745B7F9C87872667906@intel.com>
Content-Transfer-Encoding: quoted-printable

Sorry Shane: on your previous email you said

>Only "build packages" will not write logs because there is no chance for
>Users to retrieve on the GUI.


From the above I understood build packages and build images would normally
create two separate logs, but you were changing that purely because there
is no option in Hob to retrieve the build packages log. So I offered to
provide an option in the Packages screen that would allow people to
retrieve such log, if Jessica, who reported the bug, deemed it appropriate.

If I understood incorrectly just ignore my comment.

Cheers

Belen

On 04/04/2012 10:56, "Wang, Shane" <shane.wang@intel.com> wrote:

>Do you mean the image details screen is too busy with "View logs"? It was
>designed by Giulia.
>
>Retrieving the packages build log in the packages screen is not good
>because the log is also for "build image"
>
>--
>Shane
>
>Barros Pena, Belen wrote on 2012-04-03:
>
>> Sorry: this was an omission on the design side. If deemed appropriate,
>>we
>> can incorporate an option to retrieve the packages build log in the
>> Packages screen. I'll leave it to Jessica, who reported 1991, to decide
>>if
>> this is something we should provide.
>>=20
>> Cheers
>>=20
>> Belen
>>=20

---------------------------------------------------------------------
Intel Corporation (UK) Limited
Registered No. 1134945 (England)
Registered Office: Pipers Way, Swindon SN3 1RJ
VAT No: 860 2173 47

This e-mail and any attachments may contain confidential material for
the sole use of the intended recipient(s). Any review or distribution
by others is strictly prohibited. If you are not the intended
recipient, please contact the sender and delete all copies.



