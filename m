Received: from mail.windriver.com ([147.11.1.11])
	by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <Liezhi.Yang@windriver.com>) id 1RbOXI-0005zm-Gj
	for bitbake-devel@lists.openembedded.org;
	Fri, 16 Dec 2011 04:32:40 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
	by mail.windriver.com (8.14.3/8.14.3) with ESMTP id pBG3Perh014344
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL)
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 15 Dec 2011 19:25:40 -0800 (PST)
Received: from [128.224.162.196] (128.224.162.196) by ALA-HCA.corp.ad.wrs.com
	(147.11.189.50) with Microsoft SMTP Server id 14.1.255.0;
	Thu, 15 Dec 2011 19:25:40 -0800
Message-ID: <4EEABA32.8040802@windriver.com>
Date: Fri, 16 Dec 2011 11:25:38 +0800
From: Robert Yang <liezhi.yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux i686;
	rv:8.0) Gecko/20111124 Thunderbird/8.0
MIME-Version: 1.0
To: Mark Hatle <mark.hatle@windriver.com>
References: <cover.1323944674.git.liezhi.yang@windriver.com>
	<4EEA194E.9060406@windriver.com>
In-Reply-To: <4EEA194E.9060406@windriver.com>
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 0/2] Disk space monitoring
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
X-List-Received-Date: Fri, 16 Dec 2011 03:32:40 -0000
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit


Hi Mark,

Thanks for your replying, Richard suggested we add this to bitbake itself,
here is his reply in 8 months ago:

As for disk monitoring, I'd suggest we just add this to bitbake itself
as it doesn't really fit the task model. It can be controlled via some
variables like:

# Set the directories to monitor for disk usage
BB_DISKMON_DIRS = "${TMPDIR} ${DL_DIR}"
# Set the minimum amount of disk space to exit on
BB_DISKMON_MINSPACE = "1GB"
# Set the monitor frequency
BB_DISKMON_INTERVAL = "60s"

and if the variables are not set, it doesn't get activated.


// Robert


On 12/15/2011 11:59 PM, Mark Hatle wrote:
> Is the disk space monitoring implemented in the correct place in the system?
>
> I would have expected this to have been implemented in the meta/class files,
> both in the initial sanity checking and also in something that can watch the
> events and doing the repetition/rechecking as necessary.
>
> (BTW the code looks fine to me as implemented, I'm just not sure if it belongs
> in bitbake itself.)
>
> --Mark
>
> On 12/15/11 4:44 AM, Robert Yang wrote:
>> Here are the test info:
>> 1) set the following variables in conf/local.conf for testing:
>> BB_DISKMON_DIRS = "${TMPDIR} ${DL_DIR} ${SSTATE_DIR} /home/lyang1"
>> BB_DISKMON_MINSPACE = "200G"
>> BB_DISKMON_MININODES = "20M"
>> BB_DISKMON_INTERVAL = "30s"
>>
>> The TMPDIR, DL_DIR and SSTATE_DIR are in the same disk(/dev/sdb4) in
>> my build, so I added another direcotory /home/lyang1 to test the
>> ability of monitoring multi mount points.
>>
>> 2) bitbake core-image-sato
>> WARNING: The free space of /dev/sdb5 is running low (25.915GB left)
>> WARNING: The free inode of /dev/sdb5 is running low (1788.202K left)
>> WARNING: The free space of /dev/sdb4 is running low (189.309GB left)
>> WARNING: The free inode of /dev/sdb4 is running low (18005.443K left)
>>
>> 3) Aalso have tested about the following items:
>> a) Use ctrl-c to stop the monitor
>> b) The monitor should stop when the build stops
>> c) Test the space unit G, B, K(case in-sensitive) and the time unit
>> h, m, s(case-sensitive)
>>
>> // Robert
>>
>>
>> The following changes since commit 9d136b2db8f906c562cbdb23a9b238f0e237074b:
>>
>> gdk-pixbuf: Ensure the binaries can be relocated (2011-12-13 18:00:25 +0000)
>>
>> are available in the git repository at:
>> git://git.pokylinux.org/poky-contrib robert/disk-space-monitor
>> http://git.pokylinux.org/cgit.cgi/poky-contrib/log/?h=robert/disk-space-monitor
>>
>> Robert Yang (2):
>> Disk space monitoring
>> Add config sample for disk space monitoring
>>
>> bitbake/bin/bitbake | 12 +++
>> bitbake/lib/bb/monitordisk.py | 153 +++++++++++++++++++++++++++++++++++++
>> meta-yocto/conf/local.conf.sample | 28 +++++++
>> 3 files changed, 193 insertions(+), 0 deletions(-)
>> create mode 100644 bitbake/lib/bb/monitordisk.py
>>
>
>
> _______________________________________________
> bitbake-devel mailing list
> bitbake-devel@lists.openembedded.org
> http://lists.linuxtogo.org/cgi-bin/mailman/listinfo/bitbake-devel
>


