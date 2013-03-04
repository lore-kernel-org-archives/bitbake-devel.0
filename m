Received: from mail1.windriver.com ([147.11.146.13])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <mark.hatle@windriver.com>) id 1UCXtJ-0000dx-2N
	for bitbake-devel@lists.openembedded.org;
	Mon, 04 Mar 2013 17:05:30 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail1.windriver.com (8.14.5/8.14.3) with ESMTP id r24Fn0qw026261
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 4 Mar 2013 07:49:00 -0800 (PST)
Received: from Marks-MacBook-Pro.local (172.25.36.233) by
	ALA-HCA.corp.ad.wrs.com (147.11.189.50) with Microsoft SMTP Server id
	14.2.342.3; Mon, 4 Mar 2013 07:49:00 -0800
Message-ID: <5134C272.7090008@windriver.com>
Date: Mon, 4 Mar 2013 09:49:06 -0600
From: Mark Hatle <mark.hatle@windriver.com>
Organization: Wind River Systems
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8;
	rv:17.0) Gecko/20130216 Thunderbird/17.0.3
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <1362243005-12124-1-git-send-email-Martin.Jansa@gmail.com>
In-Reply-To: <1362243005-12124-1-git-send-email-Martin.Jansa@gmail.com>
Subject: Re: [PATCH] siggen: add quotes around variable values to see whitespace
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
X-List-Received-Date: Mon, 04 Mar 2013 16:05:32 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 3/2/13 10:50 AM, Martin Jansa wrote:
> * without this change it's hard to see what's changed:
>    bitbake-diffsigs sstate-cache/*/sstate-depmodwrapper-cross-cortexa8-vfp-neon-oe-linux-gnueabi-1.0-r0-cortexa8-vfp-neon-*_populate-sysroot.tgz.siginfo
>    basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bcc79e0a4356856a64141548
>    Variable TUNE_CCARGS value changed from  -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8  to  -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8
>    Hash for dependent task depmodwrapper-cross_1.0.bb.do_install changed from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3
>
> * with this change, we can see extra trailing space in first version:
>    basehash changed from 62f28c13172d38af917716d6d4b15ac5 to 9cf38842bcc79e0a4356856a64141548
>    Variable TUNE_CCARGS value changed from ' -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8 ' to ' -march=armv7-a    -mthumb -mthumb-interwork -mfloat-abi=softfp -mfpu=neon -mtune=cortex-a8'
>    Hash for dependent task depmodwrapper-cross_1.0.bb.do_install changed from 4494cb6c117309a9b4c541ad86c0aac5 to 1e3bcf2d14e5bd30a38350b41bb98db3

No objection to this patch, but it does raise the question.  Should we somehow 
strip the leading and training white space, maybe even multiple spaces (like 
above) and then use the results to generate the checksum?

If I saw the above, my first comment would be "well that's stupid, the output is 
the same"..  (Of course performance might be impacted by all of that stripping..)

--Mark

> Signed-off-by: Martin Jansa <Martin.Jansa@gmail.com>
> ---
>   lib/bb/siggen.py | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/lib/bb/siggen.py b/lib/bb/siggen.py
> index 50e4558..8861337 100644
> --- a/lib/bb/siggen.py
> +++ b/lib/bb/siggen.py
> @@ -331,12 +331,12 @@ def compare_sigfiles(a, b, recursecb = None):
>           return changed, added, removed
>
>       if 'basewhitelist' in a_data and a_data['basewhitelist'] != b_data['basewhitelist']:
> -        output.append("basewhitelist changed from %s to %s" % (a_data['basewhitelist'], b_data['basewhitelist']))
> +        output.append("basewhitelist changed from '%s' to '%s'" % (a_data['basewhitelist'], b_data['basewhitelist']))
>           if a_data['basewhitelist'] and b_data['basewhitelist']:
>               output.append("changed items: %s" % a_data['basewhitelist'].symmetric_difference(b_data['basewhitelist']))
>
>       if 'taskwhitelist' in a_data and a_data['taskwhitelist'] != b_data['taskwhitelist']:
> -        output.append("taskwhitelist changed from %s to %s" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
> +        output.append("taskwhitelist changed from '%s' to '%s'" % (a_data['taskwhitelist'], b_data['taskwhitelist']))
>           if a_data['taskwhitelist'] and b_data['taskwhitelist']:
>               output.append("changed items: %s" % a_data['taskwhitelist'].symmetric_difference(b_data['taskwhitelist']))
>
> @@ -349,7 +349,7 @@ def compare_sigfiles(a, b, recursecb = None):
>       changed, added, removed = dict_diff(a_data['gendeps'], b_data['gendeps'], a_data['basewhitelist'] & b_data['basewhitelist'])
>       if changed:
>           for dep in changed:
> -            output.append("List of dependencies for variable %s changed from %s to %s" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
> +            output.append("List of dependencies for variable %s changed from '%s' to '%s'" % (dep, a_data['gendeps'][dep], b_data['gendeps'][dep]))
>               if a_data['gendeps'][dep] and b_data['gendeps'][dep]:
>                   output.append("changed items: %s" % a_data['gendeps'][dep].symmetric_difference(b_data['gendeps'][dep]))
>       if added:
> @@ -363,7 +363,7 @@ def compare_sigfiles(a, b, recursecb = None):
>       changed, added, removed = dict_diff(a_data['varvals'], b_data['varvals'])
>       if changed:
>           for dep in changed:
> -            output.append("Variable %s value changed from %s to %s" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
> +            output.append("Variable %s value changed from '%s' to '%s'" % (dep, a_data['varvals'][dep], b_data['varvals'][dep]))
>
>       changed, added, removed = dict_diff(a_data['file_checksum_values'], b_data['file_checksum_values'])
>       if changed:
>



