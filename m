Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1QrAdJ-000512-PY
	for bitbake-devel@lists.openembedded.org;
	Wed, 10 Aug 2011 17:23:50 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id p7AFJHXU003345
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Wed, 10 Aug 2011 08:19:17 -0700 (PDT)
Received: from Macintosh-5.local (172.25.36.226) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Wed, 10 Aug 2011 08:19:17 -0700
Message-ID: <4E42A174.1010907@windriver.com>
Date: Wed, 10 Aug 2011 10:19:16 -0500
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6;
	rv:5.0) Gecko/20110624 Thunderbird/5.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1312989126.14274.386.camel@rex>
In-Reply-To: <1312989126.14274.386.camel@rex>
Subject: Re: [PATCH] bitbake/usermanual: Update to be more in sync with bitbake codebase
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
X-List-Received-Date: Wed, 10 Aug 2011 15:23:50 -0000
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

Found a typo...

On 8/10/11 10:12 AM, Richard Purdie wrote:
> Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
> ---
> diff --git a/bitbake/doc/manual/usermanual.xml b/bitbake/doc/manual/usermanual.xml
> index 7dea949..01b69b8 100644
> --- a/bitbake/doc/manual/usermanual.xml
> +++ b/bitbake/doc/manual/usermanual.xml

...

> @@ -53,10 +54,18 @@ between multiple projects using BitBake for their
>  builds.</para></listitem>
>  		<listitem><para>Should provide an inheritance mechanism to
>  share common metadata between many packages.</para></listitem>
> -                <listitem><para>Et cetera...</para></listitem>
>              </itemizedlist>
>          </para>
> -        <para>BitBake satisfies all these and many more.  Flexibility and power have always been the priorities.  It is highly extensible, supporting embedded Python code and execution of any arbitrary tasks.</para>
> +        <para>Over time it has become apparent that some further requirements were necessary:
> +            <itemizedlist>
> +                <listitem><para>Handle variants of a base recipe (native, sdk, mutliblib).</para></listitem>

"multilib"  ;)

> +                <listitem><para>Able to split metadata into layers and allow layers to override each other.</para></listitem>
> +                <listitem><para>Allow representation of a given set of input variables to a task as a checksum.</para></listitem>
> +                <listitem><para>based on that checksum, allow acceleration of builds with prebuilt components.</para></listitem>
> +            </itemizedlist>
> +        </para>
> +
> +        <para>BitBake satisfies all the original requirements and many more with extensions being made to the basic functionality to reflect the additionl requirements.  Flexibility and power have always been the priorities.  It is highly extensible, supporting embedded Python code and execution of any arbitrary tasks.</para>
>          </section>
>      </chapter>
>      <chapter>

> @@ -299,13 +366,35 @@ SRC_URI_append_1.0.7+ = "file://some_patch_which_the_new_versions_need.patch;pat
>          <title>File download support</title>
>          <section>
>              <title>Overview</title>
> -            <para>BitBake provides support to download files this procedure is called fetching. The SRC_URI is normally used to tell BitBake which files to fetch. The next sections will describe the available fetchers and their options. Each fetcher honors a set of variables and per URI parameters separated by a <quote>;</quote> consisting of a key and a value. The semantics of the variables and parameters are defined by the fetcher. BitBake tries to have consistent semantics between the different fetchers.
> +            <para>BitBake provides support to download files this procedure is called fetching and it handled by the fetch and fetch2 modules. At this point the original fetch code is considered to be replaced by fetch2 and this manual only related to the fetch2 codebase.</para>
> +
> +            <para>The SRC_URI is normally used to tell BitBake which files to fetch. The next sections will describe the available fetchers and their options. Each fetcher honors a set of variables and per URI parameters separated by a <quote>;</quote> consisting of a key and a value. The semantics of the variables and parameters are defined by the fetcher. BitBake tries to have consistent semantics between the different fetchers.
>              </para>
> +
> +            <para>The overall fetch process is that first, fetches are attempted from PREMIRRORS. If those don't work, the original SRC_URI is attempted and if that fails, bitbake will fall back to MIRRORS. Cross urls are supported, so its possible to mirror a git repostory on an http server as a tarball for example. Some example commonly used mirror defintions are:</para>

Should it be "BitBake" instead of bitbake?

"repository" and "definitions"

...


