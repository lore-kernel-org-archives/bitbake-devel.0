Return-Path: <Rob.Woolley@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 03E6B60034
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 17 Mar 2015 15:05:23 +0000 (UTC)
Received: from ALA-HCB.corp.ad.wrs.com (ala-hcb.corp.ad.wrs.com
	[147.11.189.41])
	by mail.windriver.com (8.14.9/8.14.5) with ESMTP id t2HF5K4K016625
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
	Tue, 17 Mar 2015 08:05:20 -0700 (PDT)
Received: from [128.224.146.226] (128.224.146.226) by ALA-HCB.corp.ad.wrs.com
	(147.11.189.41) with Microsoft SMTP Server (TLS) id 14.3.224.2;
	Tue, 17 Mar 2015 08:05:20 -0700
Message-ID: <550842AF.2090003@windriver.com>
Date: Tue, 17 Mar 2015 11:05:19 -0400
From: "Woolley, Rob" <rob.woolley@windriver.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64;
	rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To: Bernhard Reutner-Fischer <rep.dot.nop@gmail.com>, Richard Purdie
	<richard.purdie@linuxfoundation.org>
References: <1425047544-4820-1-git-send-email-rob.woolley@windriver.com>
	<5501AFD7.40906@windriver.com>
	<1426177814.9114.119.camel@linuxfoundation.org>
	<55033D71.5070200@windriver.com>
	<68659A0D-CBFA-461A-AF15-D6E21B54A7E5@gmail.com>
	<471B1967-EB47-4869-98B6-9A0750147888@gmail.com>
In-Reply-To: <471B1967-EB47-4869-98B6-9A0750147888@gmail.com>
X-Originating-IP: [128.224.146.226]
Cc: tom.zanussi@linux.intel.com, bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/3] knotty: Add automatic pager support
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
X-List-Received-Date: Tue, 17 Mar 2015 15:05:26 -0000
Content-Type: multipart/alternative;
	boundary="------------020005030409060001050504"

--------------020005030409060001050504
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit



On 3/13/2015 5:37 PM, Bernhard Reutner-Fischer wrote:
> On March 13, 2015 10:12:00 PM GMT+01:00, Bernhard Reutner-Fischer <rep.dot.nop@gmail.com> wrote:
>> On March 13, 2015 8:41:37 PM GMT+01:00, "Woolley, Rob"
>> <rob.woolley@windriver.com> wrote:
>>> On 03/12/2015 12:30 PM, Richard Purdie wrote:
>>>
>>>> Patches 1/2 look good, I've run into the EPIPE issue myself and I
>>> have
>>>> noticed the crazy logfile so those can likely be merged.
>>>>
>>>> I'm less sure about 3, letting the user pipe the output to less when
>>>> needed would seem to be the better way to have this rather than
>>> adding
>>>> in specific pagination support?
>>>>
>>>> Cheers,
>>>>
>>>> Richard
>>> Sounds cool.  The exception was bugging me, so I'm glad to hear those
>>> ones look good.
>>>
>>> As far as the 3rd patch is concerned: I remember when I first used
>>> bitbake, I was surprised by the flood of data coming from those
>>> options.  I would suggest that doing the automatic paging provides a
>>> better first impression and saves unnecessary typing.
>>>
>>> I noticed that lib/image/help.py and lib/bsp/help.py have auto-paging
>>> for the help command.  I've CC'd Tom Zanussi for his opinion.
>> Using PAGER is a good thing IMO.
>> Not so setting LESS or LV nor outsmarting users PAGER=cat nor
>> defaulting to less.
>> I would also not attempt to check access() et al, just let the user fix
>> her eventually broken export.
> PS:
> http://comments.gmane.org/gmane.comp.version-control.patchwork/1144
> ;)

Thanks for the feedback, Bernhard.

I set defaults for LESS and LV based on what git does for its automatic 
paging:
https://github.com/git/git/blob/master/pager.c#L77 
<https://github.com/git/git/blob/master/pager.c#L57>

The part with cat is also inspired by git:
https://github.com/git/git/blob/master/pager.c#L51 
<https://github.com/git/git/blob/master/pager.c#L34>
<https://github.com/git/git/blob/master/pager.c#L57>
I see the first 2 patches went in.  I'm going to give the automatic 
paging patch some more soak time.

If anyone is interested in trying it out, I've created a gist for it here:
https://gist.github.com/rcwoolley/c662b8e1494c58b1a24d

Regards,
Rob

--------------020005030409060001050504
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">On 3/13/2015 5:37 PM, Bernhard
      Reutner-Fischer wrote:<br>
    </div>
    <blockquote
      cite="mid:471B1967-EB47-4869-98B6-9A0750147888@gmail.com"
      type="cite">
      <pre wrap="">On March 13, 2015 10:12:00 PM GMT+01:00, Bernhard Reutner-Fischer <a class="moz-txt-link-rfc2396E" href="mailto:rep.dot.nop@gmail.com">&lt;rep.dot.nop@gmail.com&gt;</a> wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">On March 13, 2015 8:41:37 PM GMT+01:00, "Woolley, Rob"
<a class="moz-txt-link-rfc2396E" href="mailto:rob.woolley@windriver.com">&lt;rob.woolley@windriver.com&gt;</a> wrote:
</pre>
        <blockquote type="cite">
          <pre wrap="">
On 03/12/2015 12:30 PM, Richard Purdie wrote:

</pre>
        </blockquote>
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">Patches 1/2 look good, I've run into the EPIPE issue myself and I
</pre>
          </blockquote>
          <pre wrap="">have
</pre>
          <blockquote type="cite">
            <pre wrap="">noticed the crazy logfile so those can likely be merged.

I'm less sure about 3, letting the user pipe the output to less when
needed would seem to be the better way to have this rather than
</pre>
          </blockquote>
          <pre wrap="">adding
</pre>
          <blockquote type="cite">
            <pre wrap="">in specific pagination support?

Cheers,

Richard
</pre>
          </blockquote>
          <pre wrap="">Sounds cool.  The exception was bugging me, so I'm glad to hear those 
ones look good.

As far as the 3rd patch is concerned: I remember when I first used 
bitbake, I was surprised by the flood of data coming from those 
options.  I would suggest that doing the automatic paging provides a 
better first impression and saves unnecessary typing.

I noticed that lib/image/help.py and lib/bsp/help.py have auto-paging 
for the help command.  I've CC'd Tom Zanussi for his opinion.
</pre>
        </blockquote>
        <pre wrap="">
Using PAGER is a good thing IMO.
Not so setting LESS or LV nor outsmarting users PAGER=cat nor
defaulting to less.
I would also not attempt to check access() et al, just let the user fix
her eventually broken export.
</pre>
      </blockquote>
      <pre wrap="">
PS:
<a class="moz-txt-link-freetext" href="http://comments.gmane.org/gmane.comp.version-control.patchwork/1144">http://comments.gmane.org/gmane.comp.version-control.patchwork/1144</a>
;)
</pre>
    </blockquote>
    <br>
    Thanks for the feedback, Bernhard.<br>
    <br>
    I set defaults for LESS and LV based on what git does for its
    automatic paging:<br>
    <a href="https://github.com/git/git/blob/master/pager.c#L57">https://github.com/git/git/blob/master/pager.c#L77</a><br>
    <br>
    The part with cat is also inspired by git:<br>
    <a href="https://github.com/git/git/blob/master/pager.c#L34">https://github.com/git/git/blob/master/pager.c#L51</a><br>
    <a href="https://github.com/git/git/blob/master/pager.c#L57"></a><br>
    I see the first 2 patches went in.  I'm going to give the automatic
    paging patch some more soak time.<br>
    <br>
    If anyone is interested in trying it out, I've created a gist for it
    here:<br>
    <a href="https://gist.github.com/rcwoolley/c662b8e1494c58b1a24d">https://gist.github.com/rcwoolley/c662b8e1494c58b1a24d<br>
    </a><br>
    Regards,<br>
    Rob<br>
  </body>
</html>

--------------020005030409060001050504--
