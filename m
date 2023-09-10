Return-Path: <rs@ti.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00431C71153
	for <webhook@archiver.kernel.org>; Sun, 10 Sep 2023 19:31:21 +0000 (UTC)
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
 by mx.groups.io with SMTP id smtpd.web11.43032.1694374277925058599
 for <bitbake-devel@lists.openembedded.org>;
 Sun, 10 Sep 2023 12:31:18 -0700
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@ti.com header.s=ti-com-17Q1 header.b=Pud96mLY;
 spf=pass (domain: ti.com, ip: 198.47.19.141, mailfrom: rs@ti.com)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 38AJVD2t117811;
	Sun, 10 Sep 2023 14:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1694374273;
	bh=TtsEf5XhKm775fqzjN/xoOhPiceurqYQuQehYDjJR6E=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=Pud96mLYH2Nt5HHv/RK9gBiLINVPkz/0bpIJNzV6OEnFs+uPfyPpeIyTcq0SgpHHk
	 AcG7gOFjazpV7mKwaq5xz5VXMHGgSsWXDcnE/MQ1RRQMUGP4KgZNtOo40uy43b5hzV
	 6rS/RbImz/mMv36PQWYiTdo5o6NRcbpmsGx1giBo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 38AJVDv4054429
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 10 Sep 2023 14:31:13 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 10
 Sep 2023 14:31:13 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 10 Sep 2023 14:31:12 -0500
Received: from [128.247.81.144] (ileaxei01-snat.itg.ti.com [10.180.69.5])
	by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 38AJVCa4031621;
	Sun, 10 Sep 2023 14:31:13 -0500
Message-ID: <572bd389-882a-43b0-a4cd-2d5db774ce3c@ti.com>
Date: Sun, 10 Sep 2023 14:31:12 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] [bitbake-devel] [PATCH] bitbake-worker: remove the
 network flag
Content-Language: en-US, en-US-large
To: <richard.purdie@linuxfoundation.org>, <alex.kanavin@gmail.com>
CC: <bitbake-devel@lists.openembedded.org>, <denis@denix.org>,
        <reatmon@ti.com>
References: <17839F967B1914BA.4559@lists.openembedded.org>
From: Randolph Sapp <rs@ti.com>
In-Reply-To: <17839F967B1914BA.4559@lists.openembedded.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Sun, 10 Sep 2023 19:31:21 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15018

On 9/10/23 14:14, Randolph Sapp via lists.openembedded.org wrote:
> From: Randolph Sapp <rs@ti.com>
> 
> The network flag does not respect proxies as the fetch stage does [1].
> As such it only works for some users at the whim of the recipe writer.
> 
> This introduces an issue downstream as the build results are now
> dependent on the network architecture of the builder, the recipe in
> question, and the combination of proxy variables they choose to export
> in addition to the normal host variables that affect builds (host tool
> version, build environment, etc).
> 
> This is far more indeterminate than a build system that properly exports
> proxy variables. If abuse of the network tag is an issue, then the
> network tag should be removed in it's current state.
> 
> [1] https://lists.openembedded.org/g/bitbake-devel/topic/100924096
> 
> Signed-off-by: Randolph Sapp <rs@ti.com>
> ---
> 
> The logical followup to my last patch, even if it does seem a little extreme.
> 
>   bin/bitbake-worker                                    | 11 +++++------
>   .../bitbake-user-manual-metadata.rst                  |  6 ------
>   2 files changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/bin/bitbake-worker b/bin/bitbake-worker
> index 451e6926..71ff0516 100755
> --- a/bin/bitbake-worker
> +++ b/bin/bitbake-worker
> @@ -270,12 +270,11 @@ def fork_off_task(cfg, data, databuilder, workerdata, extraconfigdata, runtask):
>   
>                   bb.utils.set_process_name("%s:%s" % (the_data.getVar("PN"), taskname.replace("do_", "")))
>   
> -                if not bb.utils.to_boolean(the_data.getVarFlag(taskname, 'network')):
> -                    if bb.utils.is_local_uid(uid):
> -                        logger.debug("Attempting to disable network for %s" % taskname)
> -                        bb.utils.disable_network(uid, gid)
> -                    else:
> -                        logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
> +                if bb.utils.is_local_uid(uid):
> +                    logger.debug("Attempting to disable network for %s" % taskname)
> +                    bb.utils.disable_network(uid, gid)
> +                else:
> +                    logger.debug("Skipping disable network for %s since %s is not a local uid." % (taskname, uid))
>   
>                   # exported_vars() returns a generator which *cannot* be passed to os.environ.update()
>                   # successfully. We also need to unset anything from the environment which shouldn't be there
> diff --git a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> index 58975f4c..b35c332c 100644
> --- a/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> +++ b/doc/bitbake-user-manual/bitbake-user-manual-metadata.rst
> @@ -1519,12 +1519,6 @@ functionality of the task:
>      released. You can use this variable flag to accomplish mutual
>      exclusion.
>   
> --  ``[network]``: When set to "1", allows a task to access the network. By
> -   default, only the ``do_fetch`` task is granted network access. Recipes
> -   shouldn't access the network outside of ``do_fetch`` as it usually
> -   undermines fetcher source mirroring, image and licence manifests, software
> -   auditing and supply chain security.
> -
>   -  ``[noexec]``: When set to "1", marks the task as being empty, with
>      no execution required. You can use the ``[noexec]`` flag to set up
>      tasks as dependency placeholders, or to disable tasks defined
> 
> 
> 
> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#15017): https://lists.openembedded.org/g/bitbake-devel/message/15017
> Mute This Topic: https://lists.openembedded.org/mt/101278873/7094281
> Group Owner: bitbake-devel+owner@lists.openembedded.org
> Unsubscribe: https://lists.openembedded.org/g/bitbake-devel/unsub [rs@ti.com]
> -=-=-=-=-=-=-=-=-=-=-=-
> 

Do not merge this obviously. It breaks the fetch stage in it's current 
form. I just wanted to start another discussion. (The proper solution 
would have to be some explicit exclusions for processes in the do_fetch 
task.)

