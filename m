Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]
	helo=tim.rpsys.net) by linuxtogo.org with esmtp (Exim 4.72)
	(envelope-from <richard.purdie@linuxfoundation.org>)
	id 1S0G7t-0000dM-EL for bitbake-devel@lists.openembedded.org;
	Wed, 22 Feb 2012 18:37:13 +0100
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MHSrKT031661;
	Wed, 22 Feb 2012 17:28:53 GMT
Received: from tim.rpsys.net ([127.0.0.1])
	by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new,
	port 10024) with LMTP
	id 30866-05; Wed, 22 Feb 2012 17:28:49 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10]) (authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q1MHSjEo031655
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Feb 2012 17:28:47 GMT
Message-ID: <1329931725.20261.197.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: Robert Yang <liezhi.yang@windriver.com>
Date: Wed, 22 Feb 2012 17:28:45 +0000
In-Reply-To: <3f1562cf1c51f28221093dd13516206aa0287f6e.1329727465.git.liezhi.yang@windriver.com>
References: <cover.1329727465.git.liezhi.yang@windriver.com>
	<3f1562cf1c51f28221093dd13516206aa0287f6e.1329727465.git.liezhi.yang@windriver.com>
X-Mailer: Evolution 3.2.2- 
Mime-Version: 1.0
X-Virus-Scanned: amavisd-new at rpsys.net
Cc: bitbake-devel@lists.openembedded.org
Subject: Re: [PATCH 1/2] V4 Disk space monitoring
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
X-List-Received-Date: Wed, 22 Feb 2012 17:37:13 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi Robert,

On Mon, 2012-02-20 at 17:53 +0800, Robert Yang wrote:
> Monitor disk availability and take action when the free disk space or
> amount of free inode is running low, it is enabled when BB_DISKMON_DIRS
> is set.

I like the patch, this is a great improvement on previous versions. I
think there are some further tweaks we can make to finish it off though.

> * Variable meanings(from meta-yocto/conf/local.conf.sample):
> 
>    # Set the directories to monitor for disk usage, if more than one
>    # directories are mounted in the same device, then only one directory
>    # would be monitored since the monitor is based on the device.
>    # The format are: "directory,minimum space,minimum free inode",
>    # either space or inode (Or both of them) should be specified, otherwise
>    # the monitor would not be enabled, the unit can be G, M, K or none,
>    # but do NOT use GB, MB or KB (B is not needed).
>    #BB_DISKMON_DIRS = "${TMPDIR},1G,1K ${SSTATE_DIR},500M,1K"
>    #
>    # Set the action when the space is running low, the action is one of:
>    # ABORT: Immediately abort
>    # NO_NEW_TASK: no new tasks
>    # WARN: show warnings
>    # The default is WARN
>    #BB_DISKMON_ACTION = "WARN"

I like BB_DISKMON_DIRS. I was wondering if we should combine these
variable so you could do something like:

BB_DISKMON_DIRS = "STOPTASKS,${TMPDIR},1G,1K ABORT,${SSTATE_DIR},500M,1K"

STOPTASKS might be easier to parse than "NO_NEW_TASK". It also means
someone could set a warning threshold and a hard abort level too.

>    # Set disk space and inode interval, the unit can be G, M, or K, but do
>    # NOT use the GB, MB or KB (B is not needed), the format is:
>    # "disk space interval, disk inode interval",  the default value is
>    # "10M, 50" which means that it would warn when the free space is
>    # lower than the minimum space(or inode), and would repeat the action
>    # when the disk space reduces 10M (or the amount of inode reduces 50)
>    # again.
>    #BB_DISKMON_INTERVAL = "10M,10K"

I'm wondering how useful this interval is? Surely once we've warned,
aborted or stopped starting new tasks, running the action again isn't
much use? This is particularly true with the change I'm proposing above.

> [YOCTO #1589]
> Signed-off-by: Robert Yang <liezhi.yang@windriver.com>
> ---
>  bitbake/bin/bitbake           |    1 +
>  bitbake/lib/bb/monitordisk.py |  177 +++++++++++++++++++++++++++++++++++++++++
>  bitbake/lib/bb/runqueue.py    |   67 +++++++++++++++-
>  3 files changed, 242 insertions(+), 3 deletions(-)
>  create mode 100644 bitbake/lib/bb/monitordisk.py
> 
> diff --git a/bitbake/bin/bitbake b/bitbake/bin/bitbake
> index 6da4980..d295229 100755
> --- a/bitbake/bin/bitbake
> +++ b/bitbake/bin/bitbake
> @@ -240,6 +240,7 @@ Default BBFILES are the .bb files in the current directory.""")
>      else:
>          print("server address: %s, server port: %s" % (server.serverinfo.host, server.serverinfo.port))
>  
> +
>      return 1
>  
>  if __name__ == "__main__":

I suspect this shouldn't have been here :)

> diff --git a/bitbake/lib/bb/monitordisk.py b/bitbake/lib/bb/monitordisk.py
> new file mode 100644
> index 0000000..2ea7bdb
> --- /dev/null
> +++ b/bitbake/lib/bb/monitordisk.py
> @@ -0,0 +1,177 @@
> +#!/usr/bin/env python
> +# ex:ts=4:sw=4:sts=4:et
> +# -*- tab-width: 4; c-basic-offset: 4; indent-tabs-mode: nil -*-
> +#
> +# Copyright (C) 2012 Robert Yang
> +#
> +# This program is free software; you can redistribute it and/or modify
> +# it under the terms of the GNU General Public License version 2 as
> +# published by the Free Software Foundation.
> +#
> +# This program is distributed in the hope that it will be useful,
> +# but WITHOUT ANY WARRANTY; without even the implied warranty of
> +# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +# GNU General Public License for more details.
> +#
> +# You should have received a copy of the GNU General Public License along
> +# with this program; if not, write to the Free Software Foundation, Inc.,
> +# 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
> +
> +import time, os, logging, re, sys
> +import bb
> +logger = logging.getLogger("BitBake.Monitor")
> +
> +def errRet(info):
> +    logger.error("%s" % info)
> +    logger.error("Disk space monitor will NOT be enabled")
> +    return None
> +
> +def errRetTwo(info):
> +    logger.error("%s" % info)
> +    logger.error("Disk space monitor will NOT be enabled")
> +    return None, None

These should be one multiline logger.error() call (using \n for
newlines).

> +def convertGMK(unit):
> +
> +    """ Convert the space unit G, M, K, the unit is case-insensitive """
> +
> +    unitG = re.match('([1-9][0-9]*)[gG]\s?$', unit)
> +    if unitG:
> +        return int(unitG.group(1)) * (1024 ** 3)
> +    unitM = re.match('([1-9][0-9]*)[mM]\s?$', unit)
> +    if unitM:
> +        return int(unitM.group(1)) * (1024 ** 2)
> +    unitK = re.match('([1-9][0-9]*)[kK]\s?$', unit)
> +    if unitK:
> +        return int(unitK.group(1)) * 1024
> +    unitN = re.match('([1-9][0-9]*)\s?$', unit)
> +    if unitN:
> +        return int(unitN.group(1))
> +    else:
> +        return None
> +
> +def getMountedDev(path):
> +
> +    """ Get the device mounted at the path, uses /proc/mounts """
> +
> +    # Get the mount point of the filesystem containing path
> +    # st_dev is the ID of device containing file
> +    parentDev = os.stat(path).st_dev
> +    currentDev = parentDev
> +    # When the current directory's device is different from the
> +    # parrent's, then the current directory is a mount point
> +    while parentDev == currentDev:
> +        mountPoint = path
> +        # Use dirname to get the parrent's directory
> +        path = os.path.dirname(path)
> +        # Reach the "/"
> +        if path == mountPoint:
> +            break
> +        parentDev= os.stat(path).st_dev
> +
> +    try:
> +        with open("/proc/mounts", "r") as ifp:
> +            for line in ifp:
> +                procLines = line.rstrip('\n').split()
> +                if procLines[1] == mountPoint:
> +                    return procLines[0]
> +    except EnvironmentError:
> +        pass
> +    return None
> +
> +def getDiskData(BBDirs, configuration):
> +
> +    """Prepare disk data for disk space monitor"""
> +
> +    # Save the device IDs, need the ID to be unique (the dictionary's key is
> +    # unique), so that when more than one directories are located in the same
> +    # device, we just monitor it once
> +    devDict = {}
> +    for pathSpaceInode in BBDirs.split():
> +        # The input format is: "dir,space,inode", dir is a must, space
> +        # and inode are optional
> +        pathSpaceInodeRe = re.match('([^,]*),([^,]*),?(.*)', pathSpaceInode)
> +        if not pathSpaceInodeRe:
> +            errRet("Invalid value in BB_DISKMON_DIRS: %s" % pathSpaceInode)
> +        path = os.path.realpath(pathSpaceInodeRe.group(1))
> +        if not path:
> +            errRet("Invalid path value in BB_DISKMON_DIRS: %s" % pathSpaceInode)
> +        minSpace = pathSpaceInodeRe.group(2)
> +        # The disk space or inode is optional, but it should have a correct
> +        # value once it is specified
> +        if minSpace:
> +            minSpace = convertGMK(minSpace)
> +            if not minSpace:
> +                errRet("Invalid disk space value in BB_DISKMON_DIRS: %s" % pathSpaceInodeRe.group(2))
> +        else:
> +            # 0 means that it is not specified
> +            minSpace = None
> +
> +        minInode = pathSpaceInodeRe.group(3)
> +        if minInode:
> +            minInode = convertGMK(minInode)
> +            if not minInode:
> +                errRet("Invalid inode value in BB_DISKMON_DIRS: %s" % pathSpaceInodeRe.group(3))
> +        else:
> +            # 0 means that it is not specified
> +            minInode = None
> +
> +        if minSpace is None and minInode is None:
> +            errRet("No disk space or inode value in found BB_DISKMON_DIRS: %s" % pathSpaceInode)
> +        # mkdir for the directory since it may not exist, for example the
> +        # DL_DIR may not exist at the very beginning
> +        if not os.path.exists(path):
> +            bb.utils.mkdirhier(path)
> +        mountedDev = getMountedDev(path)
> +        devDict[mountedDev] = path, minSpace, minInode
> +    return devDict
> +
> +def getAction(configuration):
> +
> +    """ Get the disk space monitor action"""
> +
> +    action = configuration.getVar("BB_DISKMON_ACTION", 1) or "WARN"
> +    if action not in ("ABORT", "NO_NEW_TASK", "WARN"):
> +        errRet("Unknown disk space monitor action: %s" % self.action)
> +    else:
> +        return action
> +
> +def getInterval(configuration):
> +
> +    """ Get the disk space interval """
> +    interval = configuration.getVar("BB_DISKMON_INTERVAL", 1)
> +    if not interval:
> +        # The default value is 10M and 50.
> +        return 10 * 1024 * 1024, 50
> +    else:
> +        # The disk space or inode is optional, but it should have a
> +        # correct value once it is specified
> +        intervalRe = re.match('([^,]*),?\s*(.*)', interval)
> +        if intervalRe:
> +            intervalSpace = intervalRe.group(1)
> +            if intervalSpace:
> +                intervalSpace = convertGMK(intervalSpace)
> +                if not intervalSpace:
> +                    errRetTwo("Invalid disk space interval value in BB_DISKMON_INTERVAL: %s" % intervalRe.group(1))
> +            intervalInode = intervalRe.group(2)
> +            if intervalInode:
> +                intervalInode = convertGMK(intervalInode)
> +                if not intervalInode:
> +                    errRetTwo("Invalid disk inode interval value in BB_DISKMON_INTERVAL: %s" % intervalRe.group(2))
> +            return intervalSpace, intervalInode
> +        else:
> +            errRetTwo("Invalid interval value in BB_DISKMON_INTERVAL: %s" % interval)
> +
> +class diskMonitor:
> +
> +    """Prepare the disk space monitor data"""
> +
> +    def __init__(self, BBDirs, configuration):
> +        self.enableMonitor = True
> +        self.devDict = getDiskData(BBDirs, configuration)
> +        self.action = getAction(configuration)
> +        self.spaceInterval, self.inodeInterval = getInterval(configuration)
> +        if self.devDict is None or self.action is None:
> +            self.enableMonitor = False
> +        if self.spaceInterval is None and self.inodeInterval is None:
> +            self.enableMonitor = False
> diff --git a/bitbake/lib/bb/runqueue.py b/bitbake/lib/bb/runqueue.py
> index 7bf4320..0b4dcf0 100644
> --- a/bitbake/lib/bb/runqueue.py
> +++ b/bitbake/lib/bb/runqueue.py
> @@ -31,6 +31,7 @@ import fcntl
>  import logging
>  import bb
>  from bb import msg, data, event
> +from bb import monitordisk
>  
>  bblogger = logging.getLogger("BitBake")
>  logger = logging.getLogger("BitBake.RunQueue")
> @@ -771,6 +772,18 @@ class RunQueue:
>  
>          self.state = runQueuePrepare
>  
> +        # For disk space monitor
> +        self.diskMonDirs = cfgData.getVar("BB_DISKMON_DIRS", 1) or None
> +        if self.diskMonDirs:
> +            self.dm = monitordisk.diskMonitor(self.diskMonDirs, cfgData) or None
> +            self.preFreeSpace = {}
> +            self.preFreeInode = {}
> +            for dev in self.dm.devDict:
> +                self.preFreeSpace[dev] = 0
> +                self.preFreeInode[dev] = 0
> +        else:
> +            self.dm = None
> +

I'd like to properly modularise this code so the hook here would
unconditionally do something like:

self.dm = monitordisk.diskMonitor(self.diskMonDirs, cfgData)

and it would internally check the BB_DISKMON_DIRS variable.

>      def check_stamps(self):
>          unchecked = {}
>          current = []
> @@ -923,6 +936,40 @@ class RunQueue:
>  
>          return iscurrent
>  
> +    def disk_monitor_action (self, devDict):
> +
> +        """ Tack action for the monitor """
> +
> +        for dev in devDict:
> +            st = os.statvfs(devDict[dev][0])
> +            # The free space, float point number
> +            freeSpace = st.f_bavail * st.f_frsize
> +            if devDict[dev][1] is not None and freeSpace < devDict[dev][1]:
> +                # Always show warning, and this is the default "WARN" action
> +                if self.preFreeSpace[dev] == 0 or self.preFreeSpace[dev] - freeSpace > self.dm.spaceInterval:
> +                    logger.warn("The free space of %s is running low (%.3fGB left)" % (dev, freeSpace / 1024 / 1024 / 1024.0))
> +                    self.preFreeSpace[dev] = freeSpace
> +                if self.dm.action == "NO_NEW_TASK":
> +                    logger.warn("No new tasks can be excuted since BB_DISKMON_ACTION = \"NO_NEW_TASK\"!")
> +                    return 1
> +                elif self.dm.action == "ABORT":
> +                    logger.error("Immediately abort since BB_DISKMON_ACTION = \"ABORT\"!")
> +                    sys.exit(1)

Please don't do this. There is a way to immediately abort the runqueue
by calling rq.finish_runqueue(True) (see cooker.py which does this).

The return one could probably also be a finish_runqueue(False) call.

> +            # The free inodes, float point number
> +            freeInode = st.f_favail
> +            if devDict[dev][2] is not None and freeInode < devDict[dev][2]:
> +                # Always show warning, and this is the default "WARN" action
> +                if self.preFreeInode[dev] == 0 or self.preFreeInode[dev] - freeInode > self.dm.inodeInterval:
> +                    logger.warn("The free inode of %s is running low (%.3fK left)" % (dev, freeInode / 1024.0))
> +                    self.preFreeInode[dev] = freeInode
> +                elif self.dm.action  == "NO_NEW_TASK":
> +                    logger.warn("No new tasks can be excuted since BB_DISKMON_ACTION = \"NO_NEW_TASK\"!")
> +                    return 1
> +                elif self.dm.action  == "ABORT":
> +                    logger.error("Immediately abort since BB_DISKMON_ACTION = \"ABORT\"!")
> +                    sys.exit(1)
> +        return 0
> +

I think all of the above function should become a function of "class
diskMonitor" in the other file.

>      def execute_runqueue(self):
>          """
>          Run the tasks in a queue prepared by rqdata.prepare()
> @@ -946,7 +993,14 @@ class RunQueue:
>                  self.rqexe = RunQueueExecuteScenequeue(self)
>  
>          if self.state is runQueueSceneRun:
> -            retval = self.rqexe.execute()
> +            if self.dm and self.dm.enableMonitor:
> +                dm_action = self.disk_monitor_action(self.dm.devDict)
> +                if dm_action == 1:
> +                    self.rqexe.finish()
> +                else:
> +                    retval = self.rqexe.execute()
> +            else:
> +                retval = self.rqexe.execute()
>  
>          if self.state is runQueueRunInit:
>              logger.info("Executing RunQueue Tasks")
> @@ -954,10 +1008,17 @@ class RunQueue:
>              self.state = runQueueRunning
>  
>          if self.state is runQueueRunning:
> -            retval = self.rqexe.execute()
> +            if self.dm and self.dm.enableMonitor:
> +                dm_action = self.disk_monitor_action(self.dm.devDict)
> +                if dm_action == 1:
> +                    self.rqexe.finish()
> +                else:
> +                    retval = self.rqexe.execute()
> +            else:
> +                retval = self.rqexe.execute()
>  
>          if self.state is runQueueCleanUp:
> -           self.rqexe.finish()
> +            self.rqexe.finish()
>  
>          if self.state is runQueueComplete or self.state is runQueueFailed:
>              if self.rqexe.stats.failed:


With the above changes, you can probably just put something like:

       if self.state in [runQueueSceneRun, runQueueRunning, runQueueCleanUp]:
            self.dm.check(self)

in above if self.state is runQueueCleanUp in execute_runqueue() since
calling the finish_runqueue() would change self.state

Cheers,

Richard





