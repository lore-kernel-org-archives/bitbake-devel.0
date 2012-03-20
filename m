Received: from mga03.intel.com ([143.182.124.21])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <josh@linux.intel.com>) id 1SA31v-0000Ot-NM
	for bitbake-devel@lists.openembedded.org;
	Tue, 20 Mar 2012 18:39:31 +0100
Received: from azsmga002.ch.intel.com ([10.2.17.35])
	by azsmga101.ch.intel.com with ESMTP; 20 Mar 2012 10:30:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; d="scan'208";a="79657548"
Received: from unknown (HELO [10.255.15.207]) ([10.255.15.207])
	by AZSMGA002.ch.intel.com with ESMTP; 20 Mar 2012 10:29:25 -0700
Message-ID: <4F68BE75.7080404@linux.intel.com>
Date: Tue, 20 Mar 2012 10:29:25 -0700
From: Joshua Lock <josh@linux.intel.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:10.0.1) Gecko/20120216 Thunderbird/10.0.1
MIME-Version: 1.0
To: "Xu, Dongxiao" <dongxiao.xu@intel.com>
References: <cover.1332202341.git.josh@linux.intel.com>
	<4efa2980aa09953bf53ab4da08a0ad50000d4da0.1332202341.git.josh@linux.intel.com>
	<1332223450.1848.19.camel@dongxiao-osel>
In-Reply-To: <1332223450.1848.19.camel@dongxiao-osel>
Cc: bitbake-devel@lists.openembedded.org, Giulia Piu <giulia@closertag.com>
Subject: Re: [PATCH 5/6] ui/crumbs/builder: remove OK/Cancel buttons on Layer dialog. Use Close.
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
X-List-Received-Date: Tue, 20 Mar 2012 17:39:31 -0000
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 19/03/12 23:04, Xu, Dongxiao wrote:
> On Mon, 2012-03-19 at 17:18 -0700, Joshua Lock wrote:
>> Signed-off-by: Joshua Lock<josh@linux.intel.com>
>> ---
>>   lib/bb/ui/crumbs/builder.py |    3 +--
>>   1 files changed, 1 insertions(+), 2 deletions(-)
>>
>> diff --git a/lib/bb/ui/crumbs/builder.py b/lib/bb/ui/crumbs/builder.py
>> index 1d255ac..9e85e72 100755
>> --- a/lib/bb/ui/crumbs/builder.py
>> +++ b/lib/bb/ui/crumbs/builder.py
>> @@ -668,8 +668,7 @@ class Builder(gtk.Window):
>>                        flags = gtk.DIALOG_MODAL
>>                            | gtk.DIALOG_DESTROY_WITH_PARENT
>>                            | gtk.DIALOG_NO_SEPARATOR,
>> -                     buttons = (gtk.STOCK_CANCEL, gtk.RESPONSE_NO,
>> -                                gtk.STOCK_OK, gtk.RESPONSE_YES))
>> +                     buttons = (gtk.STOCK_CLOSE, gtk.RESPONSE_YES))
>
> If users did some trial operations, for example deleted some layers, is
> it better that we provide a "cancel" button for users to ignore their
> changes?
>
> Need comments from Belen and Giulia.

Fair point, I'll wait for input from the design team for this one.

Cheers,
Joshua
-- 
Joshua '贾詡' Lock
         Yocto Project "Johannes factotum"
         Intel Open Source Technology Centre


