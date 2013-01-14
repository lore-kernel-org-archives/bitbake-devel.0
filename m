Received: from mail-ie0-f175.google.com ([209.85.223.175])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <wmat@alphatroop.com>) id 1TulC7-0008Qg-Ac
	for bitbake-devel@lists.openembedded.org;
	Mon, 14 Jan 2013 15:39:26 +0100
Received: by mail-ie0-f175.google.com with SMTP id qd14so5031861ieb.34
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 14 Jan 2013 06:24:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=google.com; s=20120113;
	h=mime-version:x-originating-ip:in-reply-to:references:from:date
	:message-id:subject:to:cc:content-type:x-gm-message-state;
	bh=HePrA9WaY9V1Bqcx0eJG7ADveacOq/Y6xQK3AF2LoUQ=;
	b=aJyo6VivQSkSA7ix0DVhgigG5rE1Y55oViUZ01uHzZKobJIAfwnzCTZvvWDTiTrafH
	799z4ZkoKYiuUVwEn2bkzyFI+5I1xsNf3855/pxrzVZ4qWH+8liNMfANdD1nf13toHg6
	DxSn/oBtlUYK7VqqgqCed3l/6m8x6sSwS2j9UHKBelBLfn/YNhLn4oU7WxyFVDBHacjZ
	vt9h2Ue7GbMbvNPmX3wTm8Ltzlf0H10Gh7fdqu9AmZ4+3bW8rykDnqF/8jb1KYK+4/Eu
	2ZyjCTXdGk3D8V7UGEC3yTOhQjTLMqf9+PYRCrOZ82e/inh9frxUwyHztruyqxjl6mrV
	lq7g==
Received: by 10.42.153.70 with SMTP id l6mr64440314icw.50.1358173443716; Mon,
	14 Jan 2013 06:24:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.77.230 with HTTP; Mon, 14 Jan 2013 06:23:43 -0800 (PST)
X-Originating-IP: [24.246.30.132]
In-Reply-To: <50F4106E.8070404@codesourcery.com>
References: <50F4106E.8070404@codesourcery.com>
From: Bill Traynor <wmat@alphatroop.com>
Date: Mon, 14 Jan 2013 09:23:43 -0500
Message-ID: <CAGfZjq4GBKd=qc5LQgZQ=6odp8bJgGSW72qE9N=397UjfcYGig@mail.gmail.com>
To: Andrew Stubbs <ams@codesourcery.com>
X-Gm-Message-State: ALoCoQm2GJzGqe2GWE7cMU9ZFW3G9rDzyA9Ersr7OfsNrqmBWyK9SoIqyyhWqjQdyliby+FULuT6
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: Minimal BitBake template
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
X-List-Received-Date: Mon, 14 Jan 2013 14:39:26 -0000
Content-Type: multipart/alternative; boundary=90e6ba613abaa7f7b504d34065fc

--90e6ba613abaa7f7b504d34065fc
Content-Type: text/plain; charset=ISO-8859-1

On Mon, Jan 14, 2013 at 9:04 AM, Andrew Stubbs <ams@codesourcery.com> wrote:

> Hi all,
>
> I'm trying to evaluate use of BitBake for projects other than OE.
>
> As part of that I've been experimenting, and trying to learn how it works
> by writing a minimalist working recipe set starting from a blank slate. I
> had hoped that, with the documentation and error/warning messages, I would
> be able to do this step-by-step through trial and error, and thus learn
> more than doing a straight cut-and-paste. This works up to a point, but
> I've now hit a dead end:
>
>  ERROR: An uncaught exception occured in runqueue, please see the failure
>> below:
>> ERROR: Running idle function
>> Traceback (most recent call last):
>>   File "/opt/bitbake/lib/bb/cooker.**py", line 1152, in
>> buildTargetsIdle(server=<**ProcessServer(ProcessServer-1, started)>,
>> rq=<bb.runqueue.RunQueue instance at 0x14654d0>, abort=False):
>>                  try:
>>     >                retval = rq.execute_runqueue()
>>                  except runqueue.TaskFailure as exc:
>>   File "/opt/bitbake/lib/bb/runqueue.**py", line 934, in
>> RunQueue.execute_runqueue():
>>              try:
>>     >            return self._execute_runqueue()
>>              except bb.runqueue.TaskFailure:
>>   File "/opt/bitbake/lib/bb/runqueue.**py", line 901, in
>> RunQueue._execute_runqueue():
>>              if self.state is runQueueRunning:
>>     >            retval = self.rqexe.execute()
>>
>>   File "/opt/bitbake/lib/bb/runqueue.**py", line 1365, in
>> RunQueueExecuteTasks.execute()**:
>>
>>     >            if self.rq.check_stamp_task(task, taskname,
>> cache=self.stampcache):
>>                      logger.debug(2, "Stamp current task %s (%s)", task,
>>   File "/opt/bitbake/lib/bb/runqueue.**py", line 821, in
>> RunQueue.check_stamp_task(**task=0, taskname='do_build', recurse=False,
>> cache={}):
>>              # If the stamp is missing its not current
>>     >        if not os.access(stampfile, os.F_OK):
>>                  logger.debug(2, "Stampfile %s not available", stampfile)
>> TypeError: coercing to Unicode: need string or buffer, NoneType found
>>
>
> Apparently BitBake has some kind of internal assumption about what the
> recipes/classes will look like that it doesn't explicitly check, and I
> haven't satisfied, somehow? Googling around suggests that the problem might
> be related to loops in the dependency chain, or something, but my recipe
> only has one task.
>
> Essentially, I have three files:
>
> conf/bitbake.conf
> ---8<--------------->8---
> BBFILES = "*.bb"
> CACHE = "/tmp/bbcache"
> ---8<--------------->8---
>
> classes/base.bbclass
> ---8<--------------->8---
> addtask build
>
> do_build () {
>         :
> }
> ---8<--------------->8---
>
> hello.bb
> ---8<--------------->8---
> PROVIDES="hello"
>
> do_build () {
>         echo "Hello, World!"
> }
> ---8<--------------->8---
>
> I then invoke "env BBPATH=$PWD bitbake hello" and get the above exception.
>
> Clearly, I'm missing something crucial, but what? Can you help me figure
> out what the minimal "hello world" recipe might look like?
>
> Thanks in advance
>
> Andrew
>
> P.S. I will probably end up using something based on a copy of the OE
> base-class, given there's no point in reinventing the wheel, but I'd like
> to understand how these things work from first-principles first.
>

This doesn't answer your problem directy, and you may have seen this
tutorial already, but in case not:

http://hambedded.org/blog/2012/11/24/from-bitbake-hello-world-to-an-image/

Note that I'm including a hello world example in the new BitBake User
Manual I'm working on.


>
> ______________________________**_________________
> bitbake-devel mailing list
> bitbake-devel@lists.**openembedded.org<bitbake-devel@lists.openembedded.org>
> http://lists.linuxtogo.org/**cgi-bin/mailman/listinfo/**bitbake-devel<http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel>
>

--90e6ba613abaa7f7b504d34065fc
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><br><div class=3D"gmail=
_quote">On Mon, Jan 14, 2013 at 9:04 AM, Andrew Stubbs <span dir=3D"ltr">&l=
t;<a href=3D"mailto:ams@codesourcery.com" target=3D"_blank">ams@codesourcer=
y.com</a>&gt;</span> wrote:<br>


<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">Hi all,<br>
<br>
I&#39;m trying to evaluate use of BitBake for projects other than OE.<br>
<br>
As part of that I&#39;ve been experimenting, and trying to learn how it wor=
ks by writing a minimalist working recipe set starting from a blank slate. =
I had hoped that, with the documentation and error/warning messages, I woul=
d be able to do this step-by-step through trial and error, and thus learn m=
ore than doing a straight cut-and-paste. This works up to a point, but I&#3=
9;ve now hit a dead end:<br>



<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left-width:1px;border-left-color:rgb(204,204,204);border-left-style:solid;p=
adding-left:1ex">
ERROR: An uncaught exception occured in runqueue, please see the failure be=
low:<br>
ERROR: Running idle function<br>
Traceback (most recent call last):<br>
=A0 File &quot;/opt/bitbake/lib/bb/cooker.<u></u>py&quot;, line 1152, in bu=
ildTargetsIdle(server=3D&lt;<u></u>ProcessServer(ProcessServer-1, started)&=
gt;, rq=3D&lt;bb.runqueue.RunQueue instance at 0x14654d0&gt;, abort=3DFalse=
):<br>



=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0try:<br>
=A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0retval =3D rq.execute_runqueue(=
)<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0except runqueue.TaskFailure as exc:<br>
=A0 File &quot;/opt/bitbake/lib/bb/runqueue.<u></u>py&quot;, line 934, in R=
unQueue.execute_runqueue():<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0try:<br>
=A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0return self._execute_runqueue()<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0except bb.runqueue.TaskFailure:<br>
=A0 File &quot;/opt/bitbake/lib/bb/runqueue.<u></u>py&quot;, line 901, in R=
unQueue._execute_runqueue():<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0if self.state is runQueueRunning:<br>
=A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0retval =3D self.rqexe.execute()<br>
<br>
=A0 File &quot;/opt/bitbake/lib/bb/runqueue.<u></u>py&quot;, line 1365, in =
RunQueueExecuteTasks.execute()<u></u>:<br>
<br>
=A0 =A0 &gt; =A0 =A0 =A0 =A0 =A0 =A0if self.rq.check_stamp_task(task, taskn=
ame, cache=3Dself.stampcache):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0logger.debug(2, &quot;Stamp curr=
ent task %s (%s)&quot;, task,<br>
=A0 File &quot;/opt/bitbake/lib/bb/runqueue.<u></u>py&quot;, line 821, in R=
unQueue.check_stamp_task(<u></u>task=3D0, taskname=3D&#39;do_build&#39;, re=
curse=3DFalse, cache=3D{}):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0# If the stamp is missing its not current<br>
=A0 =A0 &gt; =A0 =A0 =A0 =A0if not os.access(stampfile, os.F_OK):<br>
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0logger.debug(2, &quot;Stampfile %s not a=
vailable&quot;, stampfile)<br>
TypeError: coercing to Unicode: need string or buffer, NoneType found<br>
</blockquote>
<br>
Apparently BitBake has some kind of internal assumption about what the reci=
pes/classes will look like that it doesn&#39;t explicitly check, and I have=
n&#39;t satisfied, somehow? Googling around suggests that the problem might=
 be related to loops in the dependency chain, or something, but my recipe o=
nly has one task.<br>



<br>
Essentially, I have three files:<br>
<br>
conf/bitbake.conf<br>
---8&lt;---------------&gt;8---<br>
BBFILES =3D &quot;*.bb&quot;<br>
CACHE =3D &quot;/tmp/bbcache&quot;<br>
---8&lt;---------------&gt;8---<br>
<br>
classes/base.bbclass<br>
---8&lt;---------------&gt;8---<br>
addtask build<br>
<br>
do_build () {<br>
=A0 =A0 =A0 =A0 :<br>
}<br>
---8&lt;---------------&gt;8---<br>
<br>
<a href=3D"http://hello.bb" target=3D"_blank">hello.bb</a><br>
---8&lt;---------------&gt;8---<br>
PROVIDES=3D&quot;hello&quot;<br>
<br>
do_build () {<br>
=A0 =A0 =A0 =A0 echo &quot;Hello, World!&quot;<br>
}<br>
---8&lt;---------------&gt;8---<br>
<br>
I then invoke &quot;env BBPATH=3D$PWD bitbake hello&quot; and get the above=
 exception.<br>
<br>
Clearly, I&#39;m missing something crucial, but what? Can you help me figur=
e out what the minimal &quot;hello world&quot; recipe might look like?<br>
<br>
Thanks in advance<br>
<br>
Andrew<br>
<br>
P.S. I will probably end up using something based on a copy of the OE base-=
class, given there&#39;s no point in reinventing the wheel, but I&#39;d lik=
e to understand how these things work from first-principles first.<br>

</blockquote><div><br></div><div style>This doesn&#39;t answer your problem=
 directy, and you may have seen this tutorial already, but in case not:</di=
v><div style><br></div><div style><a href=3D"http://hambedded.org/blog/2012=
/11/24/from-bitbake-hello-world-to-an-image/">http://hambedded.org/blog/201=
2/11/24/from-bitbake-hello-world-to-an-image/</a></div>

<div style><br></div><div style>Note that I&#39;m including a hello world e=
xample in the new BitBake User Manual I&#39;m working on.</div><div style>=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left-width:1px;border-left-color:rgb(204,204,204);border-left-styl=
e:solid;padding-left:1ex">



<br>
______________________________<u></u>_________________<br>
bitbake-devel mailing list<br>
<a href=3D"mailto:bitbake-devel@lists.openembedded.org" target=3D"_blank">b=
itbake-devel@lists.<u></u>openembedded.org</a><br>
<a href=3D"http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-deve=
l" target=3D"_blank">http://lists.linuxtogo.org/<u></u>cgi-bin/mailman/list=
info/<u></u>bitbake-devel</a><br>
</blockquote></div><br></div></div>

--90e6ba613abaa7f7b504d34065fc--
