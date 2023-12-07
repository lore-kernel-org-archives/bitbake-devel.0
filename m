Return-Path: <marlon.rodriguez-garcia@savoirfairelinux.com>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 369CFC46CA3
	for <webhook@archiver.kernel.org>; Thu,  7 Dec 2023 21:50:01 +0000 (UTC)
Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
 by mx.groups.io with SMTP id smtpd.web11.104740.1701985794972098163
 for <bitbake-devel@lists.openembedded.org>;
 Thu, 07 Dec 2023 13:49:55 -0800
Authentication-Results: mx.groups.io;
 dkim=pass header.i=@savoirfairelinux.com header.s=DFC430D2-D198-11EC-948E-34200CB392D2 header.b=G+Lqcyrk;
 spf=pass (domain: savoirfairelinux.com, ip: 208.88.110.44, mailfrom: marlon.rodriguez-garcia@savoirfairelinux.com)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id DC9A09C280A;
	Thu,  7 Dec 2023 16:49:53 -0500 (EST)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id l1tyumKlJyTs; Thu,  7 Dec 2023 16:49:53 -0500 (EST)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 620E19C3474;
	Thu,  7 Dec 2023 16:49:53 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 620E19C3474
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1701985793; bh=6b9yfYdPwyXJFXk1pwM6iSZbFTSEmFEUvJqQ3bGU6ZI=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=G+Lqcyrk6dQLHj+Ir4pd5rfxEnBRv4rEDH7Tb4iQiypEDI6CbDo4D91y03hIutnbh
	 oNGQCbwIG4GggdWK21cgfeE8ob3kwUGoxPUcPI4MjeF6NOk5oC9VjdlKQbwIsOK7H9
	 hgyEtsla32DvA1cHWmcA1AbF2YYAXPTM6m0GSznf0nIfoa7X8G8YgGcD9m6Z1rz5pr
	 KCQnk3Q2ydfGTqJtrAipLe9c1m4vXC3iWNUmmNia0yySxEkhZkWvLSmvQ/7UuNbK65
	 tdUXY7Xy82ungTJDngIMu1HdLmzfKwBPyZUAKWbKwvSM/gOY6NFhjCgriT/u2UMN3F
	 AHc3PsO1HJGdA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id gE3zo-9Azv2S; Thu,  7 Dec 2023 16:49:53 -0500 (EST)
Received: from savoirfairelinux.ht.home (modemcable141.201-58-74.mc.videotron.ca [74.58.201.141])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id 3C4C49C280A;
	Thu,  7 Dec 2023 16:49:53 -0500 (EST)
From: Marlon Rodriguez Garcia <marlon.rodriguez-garcia@savoirfairelinux.com>
To: bitbake-devel@lists.openembedded.org,
	toaster@lists.yoctoproject.org
Subject: [toaster][PATCH 0/1] Update test build for toaster 
Date: Thu,  7 Dec 2023 16:49:43 -0500
Message-Id: <20231207214944.216242-1-marlon.rodriguez-garcia@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
List-Id: <bitbake-devel.lists.openembedded.org>
X-Webhook-Received: from li982-79.members.linode.com [45.33.32.79] by
 aws-us-west-2-korg-lkml-1.web.codeaurora.org with HTTPS for
 <bitbake-devel@lists.openembedded.org>; Thu, 07 Dec 2023 21:50:01 -0000
X-Groupsio-URL: https://lists.openembedded.org/g/bitbake-devel/message/15632


Updated test build for toaster, the testing locally was done using a smal=
ler library('perl-native') in order to save time to fix the test and this=
 were the results:

../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Build_Unique_Cooker_Log_Path PASSED                       =
           [  3%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Build_Unique_Name PASSED                                  =
           [  4%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Package_Build_Id PASSED                                   =
           [  5%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Package_Dependency PASSED                                 =
           [  5%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Package_Installed_Size_Not_NULL PASSED                    =
           [  6%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Package_Name_For_Number PASSED                            =
           [  6%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Package_Recipe_Id PASSED                                  =
           [  7%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Package_Revision_Starts_With_r PASSED                     =
           [  8%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Package_Version_Starts_With_Number PASSED                 =
           [  8%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Recipe_Dependency PASSED                                  =
           [  9%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Target_File_Name_Populated PASSED                         =
           [ 10%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Target_Installed_Package PASSED                           =
           [ 10%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_Dependency PASSED                                    =
           [ 11%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_If_Outcome_0_4_Sstate_Result_Must_Be_0_1_2 PASSED    =
           [ 11%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_If_Outcome_1_3_Sstate_Result_Must_Be_0 PASSED        =
           [ 12%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_If_Outcome_2_Sstate_Result_Must_Be_3 PASSED          =
           [ 13%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_If_Task_Executed_False_Outcome_1_2_3_5 PASSED        =
           [ 13%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_If_Task_Executed_False_Script_Type_0 PASSED          =
           [ 14%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_If_Task_Executed_True_Outcome_0_4 PASSED             =
           [ 15%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_If_Task_Executed_True_Script_Type_0_2_3 PASSED       =
           [ 15%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_Order_Sequence PASSED                                =
           [ 16%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_Task_Unique_Order PASSED                                  =
           [ 16%]
../bitbake/lib/toaster/tests/builds/test_core_image_min.py::BuildCoreImag=
eMinimal::test_custom_packages_generated PASSED                          =
           [ 17%]


