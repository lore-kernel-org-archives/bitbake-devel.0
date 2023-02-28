Return-Path: <michael.opdenacker@bootlin.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA539C7EE30
	for <webhook@archiver.kernel.org>; Tue, 28 Feb 2023 09:16:17 +0000 (UTC)
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
 by mx.groups.io with SMTP id smtpd.web10.19257.1677575775226321638
 for <bitbake-devel@lists.openembedded.org>;
 Tue, 28 Feb 2023 01:16:16 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@bootlin.com header.s=gm1 header.b=Kyhl4V2v;
 spf=pass (domain: bootlin.com, ip: 217.70.183.200, mailfrom: michael.opdenacker@bootlin.com)
Received: (Authenticated sender: michael.opdenacker@bootlin.com)
	by mail.gandi.net (Postfix) with ESMTPSA id 0E7B520003;
	Tue, 28 Feb 2023 09:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1677575773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUrgrVJaO9BM11vs2iZcor4+U7DbeBNnzWOwKSHFLYY=;
	b=Kyhl4V2vj0tV+whvJl9N7WRoq2efIJ2qKTgWjSAUr5ldEqInClefUNbIwjrv+qrrPsnX34
	9aYk3/c8fWEROD9WU/jp4razJKnoTsEA0Qk5eDSjJ0ycxzE7HU2AXGgbGFdzm4Hh9O1QSf
	zgbqY8dWDAunMRzN4sxA/18irJi9Rg8wh8OoCn4usxiERsEOFbURfaxlSGTVGkAbt7Xp5i
	wK8uwzb7PEhbKJiUkESjIHlE88EG8Vf8vmqdgFTO9KIN7sYvsb7C5gSElLF/y2j44enLZK
	7fzjvPh7buWibfB64hFfWumQxw4dQziqhiBrf+oiYCu1VyH/8Ab5nwSTMIAhkw==
Message-ID: <1b239014-ff1f-92f4-94a4-d756cc6e1f57@bootlin.com>
Date: Tue, 28 Feb 2023 10:16:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Cc: Ever ATILANO <ever.atilano@smile.fr>,
 YP docs mailing list <docs@lists.yoctoproject.org>
Subject: Re: [bitbake-devel] [PATCH v2 2/2] bitbake-user-manual: update Hello
 World example
Content-Language: en-US
To: Yoann Congal <yoann.congal@smile.fr>, Fawzi KHABER
 <fawzi.khaber@smile.fr>, bitbake-devel@lists.openembedded.org
References: <20230227135115.29202-1-fawzi.khaber@smile.fr>
 <20230227135115.29202-2-fawzi.khaber@smile.fr>
 <3ffcb4a2-f71e-cf47-29fd-bb2073316821@bootlin.com>
 <4984ee49-eb42-4891-f9fc-7ce7dc79f2ab@smile.fr>
From: Michael Opdenacker <michael.opdenacker@bootlin.com>
Organization: Bootlin
In-Reply-To: <4984ee49-eb42-4891-f9fc-7ce7dc79f2ab@smile.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Tue, 28 Feb 2023 09:16:17 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/14506

Hi Yoann,

On 27.02.23 at 19:13, Yoann Congal wrote:
> Hi Michael,
>
> On 2/27/23 18:42, Michael Opdenacker wrote:
>>>          When you run BitBake, it begins looking for metadata files. The
>>>        :term:`BBPATH` variable is what tells BitBake where
>>> @@ -254,17 +242,6 @@ Following is the complete "Hello World" example.
>>
>> Wait, before this, it seems you forgot to update the output of the "bitbake" command right after setting the BBPATH variable. Or maybe you didn't work with the "master" branch. Here's what I get when I use bitbake from the current Poky master branch:
>>
>> $bitbake
>> Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.
>>
>> Unless there's something in my environment that makes BitBake behave differently, but that's worth double checking anyway.
> FYI, we already did some back and forth internally on this ^^
>
> Be sure to have the BBPATH envvar unset before starting. Its really easy mixing shells and reusing one that did have a OE env sourced at some point and so an active BBPATH envvar.
>
> Here is a minimal script I used to reproduce the output in the patch.
>
>    $ printenv |grep BBPATH # ensure $BBPATH is not set
>    $ git clone git://git.openembedded.org/bitbake # clone latest master bitbake
>    $ cd bitbake/
>    $ ./bin/bitbake --version
>    BitBake Build Tool Core version 2.3.1
>    
>    $ export PATH=$PWD/bin:$PATH
>    $ which bitbake # must point to the above bitbake
>    
>    $ mkdir ../hello && cd ../hello/
>    $ bitbake
>    ERROR: The BBPATH variable is not set and bitbake did not find a conf/bblayers.conf file in the expected location.
>    Maybe you accidentally invoked bitbake from the wrong directory?
>
> I guess the following differences come from the same reason.
>
> Can you try again with the above script?


I've just tested this so far, and I have the same output as you do.

However, when I run "bitbake" again after setting BBPATH (step 4), I get 
an error message that is not mentioned in the patch (which doesn't 
update step 4):

ERROR: Unable to parse 
/home/mike/work/git/git.openembedded.org/bitbake/lib/bb/parse/__init__.py
Traceback (most recent call last):
   File 
"/home/mike/work/git/git.openembedded.org/bitbake/lib/bb/parse/__init__.py", 
line 127, in resolve_file(fn='conf/bitbake.conf', 
d=<bb.data_smart.DataSmart object at 0x7fbe7a5200a0>):
              if not newfn:
     >            raise IOError(errno.ENOENT, "file %s not found in %s" 
% (fn, bbpath))
              fn = newfn
FileNotFoundError: [Errno 2] file conf/bitbake.conf not found in 
/home/mike/tmp/hello

I confirm I'm using the latest bitbake.


>>>        exists, you can run the ``bitbake`` command again::
>>>             $ bitbake
>>> -       ERROR: Traceback (most recent call last):
>>> -         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 163, in wrapped
>>> -           return func(fn, *args)
>>> -         File "/home/scott-lenovo/bitbake/lib/bb/cookerdata.py", line 177, in _inherit
>>> -           bb.parse.BBHandler.inherit(bbclass, "configuration INHERITs", 0, data)
>>> -         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/BBHandler.py", line 92, in inherit
>>> -           include(fn, file, lineno, d, "inherit")
>>> -         File "/home/scott-lenovo/bitbake/lib/bb/parse/parse_py/ConfHandler.py", line 100, in include
>>> -           raise ParseError("Could not %(error_out)s file %(fn)s" % vars(), oldfn, lineno)
>>> -       ParseError: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
>>> -
>>>           ERROR: Unable to parse base: ParseError in configuration INHERITs: Could not inherit file classes/base.bbclass
>>>          In the sample output,
>>
>> Same here. At this stage on Poky master, I get:
>> $bitbake
>> Nothing to do.  Use 'bitbake world' to build everything, or run 'bitbake --help' for usage information.


Now, I'm getting something different. Maybe I wasn´t referring to the 
right step (step 6 here). I have the same error but with extra details:

ERROR: Unable to parse 
/home/mike/work/git/git.openembedded.org/bitbake/lib/bb/parse/parse_py/BBHandler.py
Traceback (most recent call last):
   File 
"/home/mike/work/git/git.openembedded.org/bitbake/lib/bb/parse/parse_py/BBHandler.py", 
line 67, in inherit(files=['base'], fn='configuration INHERITs', 
lineno=0, d=<bb.data_smart.DataSmart object at 0x7fac30c200a0>):
              if not os.path.exists(file):
     >            raise ParseError("Could not inherit file %s" % (file), 
fn, lineno)

bb.parse.ParseError: ParseError in configuration INHERITs: Could not 
inherit file classes/base.bbclass

I think at least there should be a "..." line to indicate that there are 
more lines between the bitbake command and the final line. Unless I'm 
the only one getting this.

>>> @@ -284,7 +261,10 @@ Following is the complete "Hello World" example.
>>>          $ mkdir classes
>>>          Move to the ``classes`` directory and then create the
>>> -    ``base.bbclass`` file by inserting this single line: addtask build
>>> +    ``base.bbclass`` file by inserting this single line::
>>> +
>>> +      addtask build
>>> +
>>>        The minimal task that BitBake runs is the ``do_build`` task. This is
>>>        all the example needs in order to build the project. Of course, the
>>>        ``base.bbclass`` can have much more depending on which build
>>
>> Good catch. This is ugly in the current docs.
>>
>>> @@ -328,10 +308,11 @@ Following is the complete "Hello World" example.
>>>          BBFILES += "${LAYERDIR}/*.bb"
>>>          BBFILE_COLLECTIONS += "mylayer"
>>>          BBFILE_PATTERN_mylayer := "^${LAYERDIR_RE}/"
>>> +      LAYERSERIES_COMPAT_mylayer = "dunfell"
>> You may mention that "dunfell" is just an example, and should be adapted to the OpenEmbedded-Core version(s) that your layer supports. By the way, "kirkstone" should be a better choice as it should last longer than "dunfell".
>>
>> By the way, wishing we had a DISTRO_NAME_NO_CAP macro like in the YP manual, but that's will be a separate topic.


This should still be addressed.

Fawzi, could you send an update addressing at least the above remarks?

Then, I'll be happy to test your new instructions again.

Thanks again,

Cheers
Michael.

-- 
Michael Opdenacker, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


