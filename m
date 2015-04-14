Return-Path: <Qi.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	by mail.openembedded.org (Postfix) with ESMTP id 170386E268
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 09:25:19 +0000 (UTC)
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com
	[147.11.189.40])
	by mail.windriver.com (8.14.9/8.14.9) with ESMTP id t3E9PKMv014153
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Tue, 14 Apr 2015 02:25:21 -0700 (PDT)
Received: from [128.224.162.236] (128.224.162.236) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.224.2;
	Tue, 14 Apr 2015 02:25:25 -0700
Message-ID: <552CDD04.8040204@windriver.com>
Date: Tue, 14 Apr 2015 17:25:24 +0800
From: ChenQi <Qi.Chen@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64;
	rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To: <bitbake-devel@lists.openembedded.org>
References: <cover.1425969366.git.Qi.Chen@windriver.com>
	<0db087157f7aeabca45cf27e64b200dea9b08c41.1425969366.git.Qi.Chen@windriver.com>
In-Reply-To: <0db087157f7aeabca45cf27e64b200dea9b08c41.1425969366.git.Qi.Chen@windriver.com>
X-Originating-IP: [128.224.162.236]
Subject: Re: [PATCH 1/1] bitbake-diffsigs: consider the situation where sigdata and siginfo files having the same hash values
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
X-List-Received-Date: Tue, 14 Apr 2015 09:25:21 -0000
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit

ping

Any comment on this one?

Best Regards,
Chen Qi

On 03/11/2015 11:21 AM, Chen Qi wrote:
> For now, `bitbake-diffsigs -t <recipe> <task>' doesn't work. It always outputs
> nothing.
>
> The problem is that bitbake-diffsigs are comparing sigdata and siginfo files
> that have the same hash value. This is not what we want. These two files are
> actually duplicates considering the purpose of bitbake-diffsigs. So we need
> to remove one of them so that bitbake-diffsigs could actually compare the
> correct signature files.
>
> Signed-off-by: Chen Qi <Qi.Chen@windriver.com>
> ---
>   bitbake/bin/bitbake-diffsigs | 18 +++++++++++++++++-
>   1 file changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/bitbake/bin/bitbake-diffsigs b/bitbake/bin/bitbake-diffsigs
> index 08ae00d..196f0b7 100755
> --- a/bitbake/bin/bitbake-diffsigs
> +++ b/bitbake/bin/bitbake-diffsigs
> @@ -46,6 +46,12 @@ logger = logger_create('bitbake-diffsigs')
>   def find_compare_task(bbhandler, pn, taskname):
>       """ Find the most recent signature files for the specified PN/task and compare them """
>   
> +    def get_hashval(siginfo):
> +        if siginfo.endswith('.siginfo'):
> +            return siginfo.rpartition(':')[2].partition('_')[0]
> +        else:
> +            return siginfo.rpartition('.')[2]
> +
>       if not hasattr(bb.siggen, 'find_siginfo'):
>           logger.error('Metadata does not support finding signature data files')
>           sys.exit(1)
> @@ -54,7 +60,7 @@ def find_compare_task(bbhandler, pn, taskname):
>           taskname = 'do_%s' % taskname
>   
>       filedates = bb.siggen.find_siginfo(pn, taskname, None, bbhandler.config_data)
> -    latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-2:]
> +    latestfiles = sorted(filedates.keys(), key=lambda f: filedates[f])[-3:]
>       if not latestfiles:
>           logger.error('No sigdata files found matching %s %s' % (pn, taskname))
>           sys.exit(1)
> @@ -62,6 +68,16 @@ def find_compare_task(bbhandler, pn, taskname):
>           logger.error('Only one matching sigdata file found for the specified task (%s %s)' % (pn, taskname))
>           sys.exit(1)
>       else:
> +        # It's possible that latestfiles contain 3 elements and the first two have the same hash value.
> +        # In this case, we delete the second element.
> +        # The above case is actually the most common one. Because we may have sigdata file and siginfo
> +        # file having the same hash value. Comparing such two files makes no sense.
> +        if len(latestfiles) == 3:
> +            hash0 = get_hashval(latestfiles[0])
> +            hash1 = get_hashval(latestfiles[1])
> +            if hash0 == hash1:
> +                latestfiles.pop(1)
> +
>           # Define recursion callback
>           def recursecb(key, hash1, hash2):
>               hashes = [hash1, hash2]


