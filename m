Received: from m13-70.163.com ([220.181.13.70])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <huanmateme@163.com>) id 1TsPR4-00028q-QU
	for bitbake-devel@lists.openembedded.org;
	Tue, 08 Jan 2013 04:01:13 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Received:Date:From:To:Cc:Subject:In-Reply-To:
	References:Content-Type:MIME-Version:Message-ID; bh=q9mjYeYez0UI
	gyKFjcOSd3F1mAOlOlDt1t6KPfZ8c34=; b=FRWD7fJ7O6uZPSt8vNWkWMC9TRx7
	3koaNcuf9a4U6YSgDmUdLC3X8TuMO3P3Kh/emgmyyigJtQw0JReA4xxa8+e6LCsx
	kmXPF19sZ1Vq32FxJEVosxrLKoyBT6k5yX0HQYyQiz7Buhs3u/8q1cs2yLGOE3ya
	9kj0hRdMEKQ7jo4=
Received: from huanmateme$163.com ( [61.148.56.138] ) by
	ajax-webmail-wmsvr70 (Coremail) ; Tue, 8 Jan 2013 10:30:33 +0800 (CST)
X-Originating-IP: [61.148.56.138]
Date: Tue, 8 Jan 2013 10:30:33 +0800 (CST)
From: Biao  <huanmateme@163.com>
To: "Richard Purdie" <richard.purdie@linuxfoundation.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version SP_ntes V3.5 build
	20121219(21170.5156.5150) Copyright (c) 2002-2013 www.mailtech.cn
	163com
In-Reply-To: <1357594743.25855.46.camel@ted>
References: <45483db.6a2c.13bbc028c57.Coremail.huanmateme@163.com>
	<1357594743.25855.46.camel@ted>
MIME-Version: 1.0
Message-ID: <c599171.141a6.13c17feb4fa.Coremail.huanmateme@163.com>
X-CM-TRANSID: RsGowEAJT0LKhOtQRHkmAA--.5599W
X-CM-SenderInfo: xkxd0z5dwhzvi6rwjhhfrp/xtbBiBGdgE9o6ya0PgABsl
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
Cc: bitbake-dev <bitbake-devel@lists.openembedded.org>
Subject: Re: Where does the python print goes?
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
X-List-Received-Date: Tue, 08 Jan 2013 03:01:13 -0000
Content-Type: multipart/alternative; 
	boundary="----=_Part_304486_560736562.1357612233978"

------=_Part_304486_560736562.1357612233978
Content-Type: text/plain; charset=GBK
Content-Transfer-Encoding: 7bit


At 2013-01-08 05:39:03,"Richard Purdie" <richard.purdie@linuxfoundation.org> wrote:
>On Fri, 2012-12-21 at 13:49 +0800, Biao wrote:
>> Hi All,
>> 
>> 
>> I have a task in a dum.bb file, after running the task with -vDDD, i
>> can not find where the "I am the python output" goes, it is not in the
>> terminal, not in the log file. Where does the sys.__stdout__.write
>> output to?
>> 
>> 
>> /*----code snap begins---*/
>> python do_dm2 () {
>>         import sys
>>         sys.__stdout__.write("I am the python output\n")
>> }
>> addtask dm2
>> /*----code snap ends---*/
>
>Logfile in ${T} ?

Thanks for your reply.
I tried to grep it in the whole tmp directory, it is not in any log file.
>
>Cheers,
>
>Richard
>
>

------=_Part_304486_560736562.1357612233978
Content-Type: text/html; charset=GBK
Content-Transfer-Encoding: 7bit

<div style="line-height:1.7;color:#000000;font-size:14px;font-family:arial"><pre><br>At&nbsp;2013-01-08&nbsp;05:39:03,"Richard&nbsp;Purdie"&nbsp;&lt;richard.purdie@linuxfoundation.org&gt;&nbsp;wrote:
&gt;On&nbsp;Fri,&nbsp;2012-12-21&nbsp;at&nbsp;13:49&nbsp;+0800,&nbsp;Biao&nbsp;wrote:
&gt;&gt;&nbsp;Hi&nbsp;All,
&gt;&gt;&nbsp;
&gt;&gt;&nbsp;
&gt;&gt;&nbsp;I&nbsp;have&nbsp;a&nbsp;task&nbsp;in&nbsp;a&nbsp;dum.bb&nbsp;file,&nbsp;after&nbsp;running&nbsp;the&nbsp;task&nbsp;with&nbsp;-vDDD,&nbsp;i
&gt;&gt;&nbsp;can&nbsp;not&nbsp;find&nbsp;where&nbsp;the&nbsp;"I&nbsp;am&nbsp;the&nbsp;python&nbsp;output"&nbsp;goes,&nbsp;it&nbsp;is&nbsp;not&nbsp;in&nbsp;the
&gt;&gt;&nbsp;terminal,&nbsp;not&nbsp;in&nbsp;the&nbsp;log&nbsp;file.&nbsp;Where&nbsp;does&nbsp;the&nbsp;sys.__stdout__.write
&gt;&gt;&nbsp;output&nbsp;to?
&gt;&gt;&nbsp;
&gt;&gt;&nbsp;
&gt;&gt;&nbsp;/*----code&nbsp;snap&nbsp;begins---*/
&gt;&gt;&nbsp;python&nbsp;do_dm2&nbsp;()&nbsp;{
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;import&nbsp;sys
&gt;&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;sys.__stdout__.write("I&nbsp;am&nbsp;the&nbsp;python&nbsp;output\n")
&gt;&gt;&nbsp;}
&gt;&gt;&nbsp;addtask&nbsp;dm2
&gt;&gt;&nbsp;/*----code&nbsp;snap&nbsp;ends---*/
&gt;
&gt;Logfile&nbsp;in&nbsp;${T}&nbsp;?</pre><pre>
Thanks for your reply.</pre><pre>I tried to grep it in the whole tmp directory, it is not in any log file.</pre><pre>&gt;
&gt;Cheers,
&gt;
&gt;Richard
&gt;
&gt;
</pre></div>

------=_Part_304486_560736562.1357612233978--
