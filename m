Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (5751f4a1.skybroadband.com [87.81.244.161])
	by mail.openembedded.org (Postfix) with ESMTP id D07D86FD34
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 18 Jun 2014 15:52:37 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s5IFpJZW022447; Wed, 18 Jun 2014 16:52:18 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id cJ1UZMQyAhTe; Wed, 18 Jun 2014 16:52:17 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s5IFqC6q022473
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 18 Jun 2014 16:52:14 +0100
Message-ID: <1403106727.2104.72.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: "Robert P. J. Day" <rpjday@crashcourse.ca>
Date: Wed, 18 Jun 2014 16:52:07 +0100
In-Reply-To: <alpine.LFD.2.11.1406181120030.29194@localhost>
References: <alpine.LFD.2.11.1406181120030.29194@localhost>
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Cc: BitBake developer list <bitbake-devel@lists.openembedded.org>
Subject: Re: [PATCH] bitbake-user-manual-execution.xml: Update parallelization note.
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
X-List-Received-Date: Wed, 18 Jun 2014 15:52:42 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

On Wed, 2014-06-18 at 11:22 -0400, Robert P. J. Day wrote:
> Update the note to explain that current versions of BitBake
> automatically calculate the proper values for BB_NUMBER_THREADS

The current version of bitbake doesn't though.

There is an *OE* helper function which the default local.conf files use.

Cheers,

Richard

>  and
> PARALLEL_MAKE so you no longer need to set those values manually.
> 
> Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>
> 
> ---
> 
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> index 8514f23..6d49fb6 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-execution.xml
> @@ -29,11 +29,23 @@
>      </para>
> 
>      <note>
> -        Prior to executing BitBake, you should take advantage of parallel
> -        thread execution by setting the
> -        <link linkend='var-BB_NUMBER_THREADS'><filename>BB_NUMBER_THREADS</filename></link>
> -        variable in your <filename>local.conf</filename>
> -        configuration file.
> +        In order to take advantage of parallel thread execution on your build
> +        host, earlier versions of BitBake recommended setting the following
> +        variables in your project's <filename>local.conf</filename> file,
> +        based on your host's number of CPUs or multithreading
> +        capability:
> +        <literallayout class='monospaced'>
> +     BB_NUMBER_THREADS ?= ...
> +     PARALLEL_MAKE ?= ...
> +        </literallayout>
> +        The current version of BitBake now handles this automatically by
> +        assigning default values to those variables as follows:
> +        <literallayout class='monospaced'>
> +     BB_NUMBER_THREADS ?= "${@oe.utils.cpu_count()}"
> +     PARALLEL_MAKE ?= "-j ${@oe.utils.cpu_count()}"
> +        </literallayout>
> +        so you no longer need to worry about this, unless you specifically
> +        want to override this for some reason.
>      </note>
> 
>      <section id='parsing-the-base-configuration-metadata'>
> 
> -- 
> 
> ========================================================================
> Robert P. J. Day                                 Ottawa, Ontario, CANADA
>                         http://crashcourse.ca
> 
> Twitter:                                       http://twitter.com/rpjday
> LinkedIn:                               http://ca.linkedin.com/in/rpjday
> ========================================================================



