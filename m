Return-Path: <richard.purdie@linuxfoundation.org>
Received: from dan.rpsys.net (dan.rpsys.net [93.97.175.187])
	by mail.openembedded.org (Postfix) with ESMTP id C9D2C60CEB
	for <bitbake-devel@lists.openembedded.org>;
	Sun,  6 Apr 2014 10:08:37 +0000 (UTC)
Received: from localhost (dan.rpsys.net [127.0.0.1])
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu4) with ESMTP id
	s36A8WEj001629 for <bitbake-devel@lists.openembedded.org>;
	Sun, 6 Apr 2014 11:08:32 +0100
X-Virus-Scanned: Debian amavisd-new at dan.rpsys.net
Received: from dan.rpsys.net ([127.0.0.1])
	by localhost (dan.rpsys.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id JH-ba-RJIHfB for <bitbake-devel@lists.openembedded.org>;
	Sun,  6 Apr 2014 11:08:32 +0100 (BST)
Received: from [192.168.3.10] (rpvlan0 [192.168.3.10]) (authenticated bits=0)
	by dan.rpsys.net (8.14.4/8.14.4/Debian-2.1ubuntu1) with ESMTP id
	s36A8RDY001613
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT)
	for <bitbake-devel@lists.openembedded.org>;
	Sun, 6 Apr 2014 11:08:28 +0100
Message-ID: <1396778902.24597.3.camel@ted>
From: Richard Purdie <richard.purdie@linuxfoundation.org>
To: bitbake-devel <bitbake-devel@lists.openembedded.org>
Date: Sun, 06 Apr 2014 11:08:22 +0100
X-Mailer: Evolution 3.8.4-0ubuntu1 
Mime-Version: 1.0
Subject: [PATCH] fetch2: Fix bug in file checksum generation
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
X-List-Received-Date: Sun, 06 Apr 2014 10:08:39 -0000
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

For a while its been puzzling me why connman-gnome rebuilds as often as it
does. It turns out you can trigger this with a new checkout of the metadata.

The SRC_URI that is causing the problems is:

SRC_URI = "file://images/*"

and rather oddly the results in checksums for a file "." being added to
the tree, e.g.:

('.', 'ab48a68186f0e0f277c21ef4cb390b4b')

The problem is that when iterating files lists, the checksum variable can
become set yet we don't break the out from the for loop, which leads to
odd (and non-deterministic) entries being added into the file checksum list.
The exact item added probably depends on the order of items on the disk.

Before this change, bitbake-diffsigs on connman-gnome:do_fetch would report:

This task depends on the checksums of files: [
('connman-signal-03.png', 'f6c16aee57b37b73793a2f1dea433ffa'),
('connman-signal-02.png', 'ad0cd22710c097d8174121fc1023c3be'),
('connman-signal-01.png', '8842bd83d2fa9ba56480df34c727c629'),
('null_check_for_ipv4_config.patch', 'a23271e41c9fe81551244d875106af10'),
('connman-signal-05.png', '808589e7e8d502b44c7b007e9e68d48c'),
('connman-signal-04.png', 'ab48a68186f0e0f277c21ef4cb390b4b'),
('null_check_for_ipv4_config.patch', 'a23271e41c9fe81551244d875106af10'),
('0001-Removed-icon-from-connman-gnome-about-applet.patch', 'e2d8269357c1e8c84291606da24eea85'),
('0001-Removed-icon-from-connman-gnome-about-applet.patch', 'e2d8269357c1e8c84291606da24eea85'),
('.', 'ab48a68186f0e0f277c21ef4cb390b4b')]

Afterwards:

This task depends on the checksums of files: [
('connman-signal-03.png', 'f6c16aee57b37b73793a2f1dea433ffa'),
('connman-signal-02.png', 'ad0cd22710c097d8174121fc1023c3be'),
('connman-signal-01.png', '8842bd83d2fa9ba56480df34c727c629'),
('null_check_for_ipv4_config.patch', 'a23271e41c9fe81551244d875106af10'),
('connman-signal-05.png', '808589e7e8d502b44c7b007e9e68d48c'),
('connman-signal-04.png', 'ab48a68186f0e0f277c21ef4cb390b4b'),
('null_check_for_ipv4_config.patch', 'a23271e41c9fe81551244d875106af10'),
('0001-Removed-icon-from-connman-gnome-about-applet.patch', 'e2d8269357c1e8c84291606da24eea85'),
('0001-Removed-icon-from-connman-gnome-about-applet.patch', 'e2d8269357c1e8c84291606da24eea85')]

which is correct and deterministic without the "." entry.

Signed-off-by: Richard Purdie <richard.purdie@linuxfoundation.org>
---
diff --git a/bitbake/lib/bb/fetch2/__init__.py b/bitbake/lib/bb/fetch2/__init__.py
index 4335e7a..8e5342f 100644
--- a/bitbake/lib/bb/fetch2/__init__.py
+++ b/bitbake/lib/bb/fetch2/__init__.py
@@ -969,6 +969,7 @@ def get_file_checksums(filelist, pn):
                 checksum = checksum_file(f)
                 if checksum:
                     checksums.append((f, checksum))
+            continue
         elif os.path.isdir(pth):
             # Handle directories
             for root, dirs, files in os.walk(pth):
@@ -977,6 +978,7 @@ def get_file_checksums(filelist, pn):
                     checksum = checksum_file(fullpth)
                     if checksum:
                         checksums.append((fullpth, checksum))
+            continue
         else:
             checksum = checksum_file(pth)
 



