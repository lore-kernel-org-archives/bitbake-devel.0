Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1SyxJW-0002Xn-B8
	for bitbake-devel@lists.openembedded.org;
	Wed, 08 Aug 2012 05:52:06 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.5/8.14.3) with ESMTP id q783eHiB019854
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 7 Aug 2012 20:40:17 -0700 (PDT)
Received: from [128.224.163.142] (128.224.163.142) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.2.309.2;
	Tue, 7 Aug 2012 20:40:16 -0700
Message-ID: <5021DF9E.3090709@windriver.com>
Date: Wed, 8 Aug 2012 11:40:14 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:13.0) Gecko/20120615 Thunderbird/13.0.1
MIME-Version: 1.0
To: Richard Purdie <richard.purdie@linuxfoundation.org>
References: <cover.1344346253.git.liezhi.yang@windriver.com>
	<16599840.OqlgMUDr4l@helios> <1344373262.9756.300.camel@ted>
In-Reply-To: <1344373262.9756.300.camel@ted>
Cc: bitbake-devel@lists.openembedded.org, Zhenfeng.Zhao@windriver.com
Subject: Re: [PATCH 0/1] bitbake-whatchanged: print what is about to happen
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
X-List-Received-Date: Wed, 08 Aug 2012 03:52:06 -0000
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit


On 08/08/2012 05:01 AM, Richard Purdie wrote:
> On Tue, 2012-08-07 at 18:12 +0100, Paul Eggleton wrote:
>> On Tuesday 07 August 2012 23:48:55 Robert Yang wrote:
>>> The following changes since commit c86d26cb976e665b1516e72153f3f686f62dedf9:
>>>
>>>    subversion: Add missing build dependency on sqlite3 (2012-08-06 16:14:06
>>> +0100)
>>>
>>> are available in the git repository at:
>>>
>>>    git://git.pokylinux.org/poky-contrib robert/whatchanged
>>>    http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/whatchanged
>>>
>>> Robert Yang (1):
>>>    bitbake-whatchanged: print what is about to happen
>>>
>>>   bitbake/bin/bitbake-whatchanged | 334
>>> ++++++++++++++++++++++++++++++++++++++++ 1 file changed, 334 insertions(+)
>>>   create mode 100755 bitbake/bin/bitbake-whatchanged
>>
>> I tried this on top of latest master, unfortunately what I got was the
>> following:
>>
>> -------------- snip ----------------
>> Figuring out the TMPDIR ...
>> Moving the stamps to stamps.old ...
>> Generating the new stamps ... (need several minutes)
>> ERROR occurred!!! Recovering the stamps dir ...
>> Removing the newly generated stamps ...
>> Moving the stamps.old back to stamps ...
>> Traceback (most recent call last):
>>    File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 333, in <module>
>>      sys.exit(main())
>>    File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 291, in main
>>      old_recon = recon_dict(old_dict)
>>    File "/home/paul/poky/poky/bitbake/bin/bitbake-whatchanged", line 82, in recon_dict
>>      full_path_pre = "%s/%s" % (dict_in.get(dict_out.get(pn_task).get(fn)).get('path'), k)
>> NameError: global name 'fn' is not defined

Thanks Paul, I've fixed this one, my testing didn't get here before, it should
be the string 'fn', not the variable fn.

>> -------------- snip ----------------
>>
>> A couple of other things:
>>
>> 1) We ought to be able to assume that TMPDIR is the same regardless of
>> the recipe specified; this avoids having to parse all of the recipes just to
>> get the value of this variable.
>>

I'm sorry, I don't understand what did you mean here. it seems that what
I did is the same as you said: Use "bitbake -e" to figure out the TMPDIR at
the beginning, then use it elsewhere.

>> 2) I'm a little concerned with the general approach - is there no way of
>> avoiding having to copy and move around the stamps directory? It seems
>> a little risky if nothing else.
>
> I think adding a parameter to -S would be a good move for this, its
> something people likely want in conjunction with that.
>

Yes, add a parameter to "bitbake -S recipe" would be the correct way, but
as far as I know, the "-S" is a bool option currently, it doesn't accept
an argument, I think that we have the following 2 solutions:

1) Modify the "-S" to accept an argument, but this may break the the usage
    of the "bitbake -S", the currently usage is:

    bitbake -S <recipe>

    We may change it to:

    bitbake -S <tmpdir>(or stampsdir) <recipe>

    But it seems that it's not easy differentiate the argument behind "-S".

2) Use "TMPDIR(or STAMP)=<path> bitbake -S recipe", but we don't support it
    currently, but we can add an os.getenv("TMPDIR") in bitbake to achieve it,
    the BB_TMPDIR or BB_STAMP would be better, but I'm not sure whether it will
    cause other problems.

I'd like to send a patch for 2) if you are OK with it.

// Robert


> Cheers,
>
> Richard
>
>
>
>
>
>



