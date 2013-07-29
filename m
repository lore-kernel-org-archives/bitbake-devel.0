Return-Path: <paul.eggleton@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by mail.openembedded.org (Postfix) with ESMTP id 55A246B20C
	for <bitbake-devel@lists.openembedded.org>;
	Mon, 29 Jul 2013 15:02:48 +0000 (UTC)
Received: from orsmga001.jf.intel.com ([10.7.209.18])
	by orsmga102.jf.intel.com with ESMTP; 29 Jul 2013 08:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.89,770,1367996400"; d="scan'208";a="353623422"
Received: from unknown (HELO helios.localnet) ([10.252.122.206])
	by orsmga001.jf.intel.com with ESMTP; 29 Jul 2013 08:02:47 -0700
From: Paul Eggleton <paul.eggleton@linux.intel.com>
To: Petter =?ISO-8859-1?Q?Mab=E4cker?= <petter@technux.se>
Date: Mon, 29 Jul 2013 16:02:45 +0100
Message-ID: <3332347.m6ksvx6N6L@helios>
Organization: Intel Corporation
User-Agent: KMail/4.10.5 (Linux/3.8.0-26-generic; KDE/4.10.5; i686; ; )
In-Reply-To: <c8e2317302a86e93bdbe8746b02f0a42be91abcf.1375088734.git.petter@technux.se>
References: <cover.1375088734.git.petter@technux.se>
	<c8e2317302a86e93bdbe8746b02f0a42be91abcf.1375088734.git.petter@technux.se>
MIME-Version: 1.0
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/1] bitbake: runqueue: add warning in invalidate task
X-BeenThere: bitbake-devel@lists.openembedded.org
X-Mailman-Version: 2.1.12
Precedence: list
List-Id: <bitbake-devel.lists.openembedded.org>
List-Unsubscribe: <http://lists.openembedded.org/mailman/options/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=unsubscribe>
List-Archive: <http://lists.openembedded.org/pipermail/bitbake-devel/>
List-Post: <mailto:bitbake-devel@lists.openembedded.org>
List-Help: <mailto:bitbake-devel-request@lists.openembedded.org?subject=help>
List-Subscribe: <http://lists.openembedded.org/mailman/listinfo/bitbake-devel>, 
	<mailto:bitbake-devel-request@lists.openembedded.org?subject=subscribe>
X-List-Received-Date: Mon, 29 Jul 2013 15:02:48 -0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Hi Petter,

On Monday 29 July 2013 11:19:31 Petter Mab=E4cker wrote:
> Add a warning if 'bitbake -C' is executed with a task that does not
> exist.
>=20
> Fixes [YOCTO #4877]
>=20
> Signed-off-by: Petter Mab=E4cker <petter@technux.se>
> ---
>  bitbake/lib/bb/runqueue.py |    3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index fce08ee..539e9af 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -720,6 +720,9 @@ class RunQueueData:
>=20
>          def invalidate_task(fn, taskname, error_nostamp):
>              taskdep =3D self.dataCache.task_deps[fn]
> +            fnid =3D self.taskData.getfn_id(fn)
> +            if taskname not in taskData.tasks_lookup[fnid]:
> +                logger.warn("Task %s does not exist, invalidate this=
 task
> will have no effect" % taskname) if 'nostamp' in taskdep and taskname=
 in
> taskdep['nostamp']: if error_nostamp:
>                      bb.fatal("Task %s is marked nostamp, cannot inva=
lidate
> this task" % taskname)

This has now been merged with a slight tweak to the message and shortlo=
g.

Thanks,
Paul

--=20

Paul Eggleton
Intel Open Source Technology Centre

