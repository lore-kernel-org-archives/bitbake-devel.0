Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <jason.wessel@windriver.com>) id 1TEJBT-0001bI-N7
	for bitbake-devel@lists.openembedded.org;
	Wed, 19 Sep 2012 14:15:16 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q8JC2XjG008802
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Wed, 19 Sep 2012 05:02:33 -0700 (PDT)
Received: from [172.25.32.41] (172.25.32.41) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Wed, 19 Sep 2012 05:02:32 -0700
Message-ID: <5059B458.3070403@windriver.com>
Date: Wed, 19 Sep 2012 07:02:32 -0500
From: Jason Wessel <jason.wessel@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:15.0) Gecko/20120827 Thunderbird/15.0
MIME-Version: 1.0
To: Paul Eggleton <paul.eggleton@linux.intel.com>
References: <1348050342-5402-1-git-send-email-paul.eggleton@linux.intel.com>
In-Reply-To: <1348050342-5402-1-git-send-email-paul.eggleton@linux.intel.com>
X-Enigmail-Version: 1.4.4
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH] hob: report event handler failures
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
X-List-Received-Date: Wed, 19 Sep 2012 12:15:16 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On 09/19/2012 05:25 AM, Paul Eggleton wrote:
> If an event handler failed we were not recieving an error message -
> parsing just "froze" at 99%. This is because we were expecting a
> CommandFailure event and this never happened in the case of
> RequestPackageInfo which is where the failure was occurring.
>
> This also required tweaking the error formatting slightly, taking the
> return value of the format function rather than the message property
> since the latter only seems to contain the first line without the
> traceback in the case of event handler failure. Other error cases were
> tested and their message formatting is unaffected by this change.
>

This looks good Paul.  

Thanks for fixing this up so we can get the reporting. :-)

Cheers,
Jason.


