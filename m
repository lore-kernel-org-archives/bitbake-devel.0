Received: from mga09.intel.com ([134.134.136.24])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1S3WwZ-0004aO-UA
	for bitbake-devel@lists.openembedded.org;
	Fri, 02 Mar 2012 19:11:04 +0100
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 02 Mar 2012 10:02:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.67,352,1309762800"; d="scan'208";a="113897728"
Received: from unknown (HELO [10.255.15.107]) ([10.255.15.107])
	by orsmga001.jf.intel.com with ESMTP; 02 Mar 2012 10:02:31 -0800
Message-ID: <4F510B37.4040108@linux.intel.com>
Date: Fri, 02 Mar 2012 10:02:31 -0800
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Wang, Shane" <shane.wang@intel.com>
References: <439e7e3c5dd2534950c63d9df57963f1a3d35944.1330523904.git.shane.wang@intel.com>
	<660576fe6e84608bbf4d7237f5804cfd244029cd.1330523904.git.shane.wang@intel.com>
	<4F4E9885.6090705@linux.intel.com>
	<3AB6CE7F274E534CAFD089D127A8A1FC23ADFD13@SHSMSX102.ccr.corp.intel.com>
In-Reply-To: <3AB6CE7F274E534CAFD089D127A8A1FC23ADFD13@SHSMSX102.ccr.corp.intel.com>
Cc: "bitbake-devel@lists.openembedded.org"
	<bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH 04/32] Hob: fixed the issue in the brought-in-by dialog.
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
X-List-Received-Date: Fri, 02 Mar 2012 18:11:04 -0000
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

On 01/03/12 23:22, Wang, Shane wrote:
> Joshua Lock wrote on 2012-03-01:
>> On 29/02/12 06:15, Shane Wang wrote:
>>> When typing any thing in the search entry, the brough-in-by dialog will be
>> shown. That is because we call back "selection-changed" signal to pop up the
>> dialog, which is not correct.
>>> This patch is to fix the problem by using "row-activated" signal.
>>>
>>> Signed-off-by: Liming An<limingx.l.an@intel.com>
>>> Signed-off-by: Shane Wang<shane.wang@intel.com>
>>
>> I point out some incorrect padding below but other than that:
>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
>
> OK, Got it. May I know why padding=6 only conforms to hig?

Of course, but you should really read it though rather than asking me to 
quote it for you.

"As a basic rule of thumb, leave space between user interface components 
in increments of 6 pixels, going up as the relationship between related 
elements becomes more distant."

http://developer.gnome.org/hig-book/3.0/design-window.html.en#window-layout-spacing

I've volunteered to work through Hob and make it more HIG conformant but 
the HIG for a platform really is a document you should at least be aware 
of when developing for it.

Cheers,
Joshua
-- 
Joshua Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


