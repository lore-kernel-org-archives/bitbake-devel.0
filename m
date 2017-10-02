Return-Path: <akuster@mvista.com>
Received: from mail-qk0-f172.google.com (mail-qk0-f172.google.com
	[209.85.220.172])
	by mail.openembedded.org (Postfix) with ESMTP id 487A871D79
	for <bitbake-devel@lists.openembedded.org>;
	Mon,  2 Oct 2017 16:02:14 +0000 (UTC)
Received: by mail-qk0-f172.google.com with SMTP id u7so5131940qku.13
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 02 Oct 2017 09:02:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=mvista-com.20150623.gappssmtp.com; s=20150623;
	h=subject:to:references:from:message-id:date:user-agent:mime-version
	:in-reply-to:content-transfer-encoding:content-language;
	bh=qBsbg7aYM4tAMPO9hsXcLGlNn6Jyg5GT3yuWm7TmyT8=;
	b=TKQwFww8JIk2fM4GU4jf2/zD815vH83nY87OkwjsNK5AHT31D1miaKhhRFYJVWFrRm
	kUREe+T49CNs5rBKS/B/ZRoS6RR8U4c6yt4xxiPcAJEwQHClUkjd9FJCN00geobUm7N6
	UqUq5DO4X9WuX/VlhJlFF2RaZd82CJIT5SxZ4bQucBkaAkc7aE7T2tp8ftfvD4Pcfk9X
	lbbHlg1U9xqdjREiw184dlxakjJhy3sL+cQF7L5LEwYmF5JqPYQeOMJfJmgAizZ222vv
	2wqDoT7XdYknOeRgIn7muXk4IrEJdsjrrbjN1RtRB9GIdzj86nlfcLr6wVDqg6TUGDXi
	6prA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:message-id:date
	:user-agent:mime-version:in-reply-to:content-transfer-encoding
	:content-language;
	bh=qBsbg7aYM4tAMPO9hsXcLGlNn6Jyg5GT3yuWm7TmyT8=;
	b=RAPJkedM7iYbJsFtnqelUnteqxoX7BafDSWkB3lWABf921aynYk7afm1wOfOB7jzrv
	sV9nJZUD/YS7ukr6KcF7FgvqYknNzBtLCoh7EIj02k3dubMpr4zZzKog3gPR8SuVNpWr
	t6yjqcJrlplwyRWSdl8PtCMSdcSTsiE5YYFvniRh+vxTC7kitrBBwrT2B2UEcox89/+B
	4qW3JOo3Qq2DS2/YSwvb0V2nDyxdQiMS3WA/7ZiI6o/XQAwX4CEl0i2JaNjIeyzA9ds4
	YxfQfhHONhDg/Ac+vLw96aauZsvB7sz3KuZbroeTI9W4epg/2ToOR//6QEFajxiHjD3m
	YQNg==
X-Gm-Message-State: AMCzsaWqXNkcqmOYYGuUjc3OIeoB5zE24/Tjh9ymFbrWLco+q42l29uI
	w1hZiTeVTgGmTMNH6u6zapB+ykBD9QA=
X-Google-Smtp-Source: AOwi7QD1JZdB4iLIp9L7OHoDMTXw1FLX4jqkUqMXYTk1fPwTuCMQtXryAFAcb8ZSorAsT9OsYI/tkg==
X-Received: by 10.55.170.15 with SMTP id t15mr8411076qke.232.1506960135793;
	Mon, 02 Oct 2017 09:02:15 -0700 (PDT)
Received: from ?IPv6:2601:202:4001:9ea0:c866:1112:ad7:1236?
	([2601:202:4001:9ea0:c866:1112:ad7:1236])
	by smtp.gmail.com with ESMTPSA id m4sm501812qtc.73.2017.10.02.09.02.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Mon, 02 Oct 2017 09:02:14 -0700 (PDT)
To: leonardo.sandoval.gonzalez@linux.intel.com,
	bitbake-devel@lists.openembedded.org
References: <20171002153849.24922-1-leonardo.sandoval.gonzalez@linux.intel.com>
	<20171002153849.24922-3-leonardo.sandoval.gonzalez@linux.intel.com>
From: akuster <akuster@mvista.com>
Message-ID: <324e7e99-7b13-5e30-36a2-4814be8f7b5b@mvista.com>
Date: Mon, 2 Oct 2017 09:02:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
	Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <20171002153849.24922-3-leonardo.sandoval.gonzalez@linux.intel.com>
Subject: Re: [PATCH 3/3] README: new readme file including main aspects of the project
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
X-List-Received-Date: Mon, 02 Oct 2017 16:02:15 -0000
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US



On 10/02/2017 08:38 AM, leonardo.sandoval.gonzalez@linux.intel.com wrote:
> From: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
>
> Includes brief description of the project, pointers to website, documentation,
> mailing list and source code.
>
> Signed-off-by: Leonardo Sandoval <leonardo.sandoval.gonzalez@linux.intel.com>
> ---
>  README | 31 +++++++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
>  create mode 100644 README
>
> diff --git a/README b/README
> new file mode 100644
> index 00000000..95ad4dd3
> --- /dev/null
> +++ b/README
> @@ -0,0 +1,31 @@
> +Bitbake
> +=======
> +
> +BitBake is a generic task execution engine that allows shell and Python tasks to be run
> +efficiently and in parallel while working within complex inter-task dependency constraints.
> +One of BitBake's main users, OpenEmbedded, takes this core and builds embedded Linux software
> +stacks using a task-oriented approach.
> +
> +For information about Bitbake, see the OpenEmbedded website:
> +    http://www.openembedded.org/
> +
> +Bitbake plain documentation can be found under the doc directory or its integrated
> +html version at the Yocto Project website:
> +    http://yoctoproject.org/documentation
> +
> +Contributing
> +------------
> +
> +Please refer to
> +http://www.openembedded.org/wiki/How_to_submit_a_patch_to_OpenEmbedded
> +for guidelines on how to submit patches, just note that the latter documentation is intended
> +for OpenEmbedded (and its core) not bitbake patches (bitbake-devel@lists.openembedded.org)
> +but in general main guidelines apply.

Is there any value in providing a sample command:

git send-patch -M -1 --subject-prefix=Bitbake][PATCH --to
bitbake-devel@lists.openembedded.org

- Armin
- armin
> +
> +Mailing list:
> +
> +    http://lists.openembedded.org/mailman/listinfo/bitbake-devel
> +
> +Source code:
> +
> +    http://git.openembedded.org/bitbake/


