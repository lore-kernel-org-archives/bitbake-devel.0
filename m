Return-Path: <chris.laplante@agilent.com>
Received: from NAM04-BN3-obe.outbound.protection.outlook.com
	(mail-eopbgr680065.outbound.protection.outlook.com [40.107.68.65])
	by mail.openembedded.org (Postfix) with ESMTP id 2E86E7FA36
	for <bitbake-devel@lists.openembedded.org>;
	Thu, 31 Oct 2019 17:36:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
	b=Bd+pikrY1OM9C/AMl3IFO39HySyYQ++Q2HHjpGPDtUTOD1TALwwvRWu3KrSNKwjStiJ3uA5BWtcoCJLOZZ1tlYznxQ+uOfobAvf7dglWY34NI7CyG4uPCc7tEh3kK6webOV8t0fIhC0qnQLZqOdEEWuYR8qkk7O9ffyQMOnKCGo611aahtaRFsJGkzFrN0HGB+JcKUl98Jeij+UGl6ItHXJZzI8J15kGM496iamZ1N+J7i1DJjdXOQe3aRvlQ/B7gGKt8boT6X3CNUkQVnoe31GwtNton622te/WdiaPN1wlbMfZie6guOkcksJJIerTt7ZT5KBRats1VqLr6b0JTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
	s=arcselector9901;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pJgsi+JJSFFK2CSqs3LGyPg3CrRHbFhmHnu9/POJj6A=;
	b=JOOWV4svDleNnnVHAZ5mz9fZyzNAS2e5zmZCf5Qb4BUAFMh2Tx1fDS8y6KKkc2h8l16JD1ow4j2u1EfRfglcFkBbVcd4mlco3uAXOeTtAxXdkm/MSBgO0Vo4LRJzLt5uCgxV1khsG4nfNj9jU9Q+PAxg2EB4aetAcbeVDv5XW4is2BSdT4uU7Hc7p6NygcUY5PgPMohfEp79AMokRY0n4dISOoGS3NT7/cIczAIY/xjmLnLU87Lk+SRqiVuseI36Xd2zs8N6cn6kv8B1gshWXiLA4LIsgUU3OvqTQUt7DJHztJwCctAIc097t4eEPRK2DD7soawCj/XpphXERcNCBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
	192.25.218.37) smtp.rcpttodomain=lists.openembedded.org
	smtp.mailfrom=agilent.com;
	dmarc=pass (p=reject sp=none pct=100) action=none
	header.from=agilent.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agilent.com;
	s=selector2;
	h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
	bh=pJgsi+JJSFFK2CSqs3LGyPg3CrRHbFhmHnu9/POJj6A=;
	b=cP7YEXn9GG82K0arnlgqW6ldenHb1Yx2XesQ7jIrNPy/LuJDvbwdfB1Hp30T3FH1QNg6IbTpAODlAMdSC2ELbaesPSrqyjBs+v66KoS3yjiKicmjfTWygrkj0oB6k7VbLSeXHPJa8LO/+3Ckv3LKJN5TUaRaqP4DlLHWQ0sXZaY=
Received: from DM5PR12CA0068.namprd12.prod.outlook.com (2603:10b6:3:103::30)
	by BYAPR12MB2999.namprd12.prod.outlook.com (2603:10b6:a03:df::18) with
	Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2387.24;
	Thu, 31 Oct 2019 17:36:34 +0000
Received: from DM3NAM05FT048.eop-nam05.prod.protection.outlook.com
	(2a01:111:f400:7e51::201) by DM5PR12CA0068.outlook.office365.com
	(2603:10b6:3:103::30) with Microsoft SMTP Server (version=TLS1_2,
	cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.2408.20 via
	Frontend Transport; Thu, 31 Oct 2019 17:36:34 +0000
Authentication-Results: spf=pass (sender IP is 192.25.218.37)
	smtp.mailfrom=agilent.com; lists.openembedded.org;
	dkim=none (message not
	signed) header.d=none;lists.openembedded.org; dmarc=pass action=none
	header.from=agilent.com;
Received-SPF: Pass (protection.outlook.com: domain of agilent.com designates
	192.25.218.37 as permitted sender) receiver=protection.outlook.com;
	client-ip=192.25.218.37; helo=edgeappmail.agilent.com;
Received: from edgeappmail.agilent.com (192.25.218.37) by
	DM3NAM05FT048.mail.protection.outlook.com (10.152.98.162) with
	Microsoft SMTP
	Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
	15.20.2387.9 via Frontend Transport; Thu, 31 Oct 2019 17:36:34 +0000
Received: from localhost.localdomain (130.30.246.172) by
	edgeappmail.agilent.com (192.25.218.37) with Microsoft SMTP Server id
	15.1.1261.35; Thu, 31 Oct 2019 11:35:56 -0600
From: Chris Laplante <chris.laplante@agilent.com>
To: <bitbake-devel@lists.openembedded.org>
Date: Thu, 31 Oct 2019 13:35:54 -0400
Message-ID: <1572543354-4229-1-git-send-email-chris.laplante@agilent.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Received-SPF: None (wpcosapexchedg1.windmz.agilent.com:
	chris.laplante@agilent.com does not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-Forefront-Antispam-Report: CIP:192.25.218.37; IPV:NLI; CTRY:US; EFV:NLI;
	SFV:NSPM;
	SFS:(10009020)(39860400002)(396003)(136003)(376002)(346002)(189003)(199004)(29502001)(51416003)(316002)(47776003)(8936002)(2906002)(50466002)(305945005)(478600001)(50226002)(7636002)(48376002)(14444005)(6916009)(246002)(16586007)(8676002)(106002)(4326008)(36756003)(70206006)(336012)(86362001)(426003)(2616005)(356004)(956004)(126002)(486006)(476003)(26005)(107886003)(5660300002)(2351001)(44832011)(186003)(5001870100001);
	DIR:OUT; SFP:1101; SCL:1; SRVR:BYAPR12MB2999;
	H:edgeappmail.agilent.com; FPR:; SPF:Pass; LANG:en;
	PTR:cos.smtp.agilent.com,wpcosapexchedg1.windmz.agilent.com;
	MX:1; A:1; 
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b92b6efd-633f-4b3c-4dac-08d75e28dfed
X-MS-TrafficTypeDiagnostic: BYAPR12MB2999:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR12MB2999BFF21F4DF50F2813E4868B630@BYAPR12MB2999.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;
X-Forefront-PRVS: 02070414A1
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: VhKHvqkYO9Iyr9qII1OEfmRFty1NRe2GwF/hz0P5VC8h65EJSE4z9PgpjfLd4i9/otMT104xnzbW+yicMa0afTk3slUSrB2TQLpa/9YtT/pEz46tvdpGUEfgDEPqtuNaM24Iu6geaIKjJg89LDp3a21dKjjdZmbZ9iwN2IX4SzWkNSoSikpGpKBc1wv90xSvIR62XTdQfMtavSy5C89zbVre0SWwGl8sQFeAoLVPYeuYYkheuzyNEMxuy6SHftz0Ml+PMH0J7S21bugt+aDiYZToIRX6NOL6HryhTf/omxDUFxwpZTL2Cc1xMi4zepFB6iPliQ+cwkilrUjlXkF4m6aPjRghqrWThEqMs0arm530lmWYFtXCBCY/I2o7AQw9doRjX88aP/puxS7dTu5bb4Hoky5uvohJObtlaSnncK6flsnJLhRAL83i2SxuOJ3IAMIpUqJauResK+lV3t7lqQ==
X-OriginatorOrg: agilent.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2019 17:36:34.1505 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b92b6efd-633f-4b3c-4dac-08d75e28dfed
X-MS-Exchange-CrossTenant-Id: a9c0bc09-8b46-4206-9351-2ba12fb4a5c0
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=a9c0bc09-8b46-4206-9351-2ba12fb4a5c0;
	Ip=[192.25.218.37]; Helo=[edgeappmail.agilent.com]
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2999
Subject: [PATCH] bitbake: command: add getOverrideData command
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
X-List-Received-Date: Thu, 31 Oct 2019 17:36:35 -0000
Content-Type: text/plain

While working on a script using tinfoil, I needed a way to access the
overridedata for a given variable. Unfortunately, I found that
data_smart does not have remotedata proxying for it.

By adding the getOverrideData command, I am able to use a method like
this to access override data (either for a particular var, or all data):

def get_override_data(d, var=None):
    if "_remote_data" in d:
        connector = d["_remote_data"]  # type: bb.tinfoil.TinfoilDataStoreConnector
        return connector.getOverrideData(var)

    if var:
        return d.overridedata[var]
    return d.overridedata

Signed-off-by: Chris Laplante <chris.laplante@agilent.com>
---
 bitbake/lib/bb/command.py | 10 ++++++++++
 bitbake/lib/bb/tinfoil.py |  4 ++++
 2 files changed, 14 insertions(+)

diff --git a/bitbake/lib/bb/command.py b/bitbake/lib/bb/command.py
index 378f389..19ee8d8 100644
--- a/bitbake/lib/bb/command.py
+++ b/bitbake/lib/bb/command.py
@@ -485,6 +485,16 @@ class CommandsSync:
         return datastore.varhistory.variable(name)
     dataStoreConnectorGetVarHistory.readonly = True
 
+    def dataStoreConnectorGetOverrideData(self, command, params):
+        dsindex = params[0]
+        datastore = command.remotedatastores[dsindex]
+        ret = datastore.overridedata
+        if len(params) > 1:
+            name = params[1]
+            return ret[name]
+        return ret
+    dataStoreConnectorGetOverrideData.readonly = True
+
     def dataStoreConnectorExpandPythonRef(self, command, params):
         config_data_dict = params[0]
         varname = params[1]
diff --git a/bitbake/lib/bb/tinfoil.py b/bitbake/lib/bb/tinfoil.py
index 0a1b913..7c8c493 100644
--- a/bitbake/lib/bb/tinfoil.py
+++ b/bitbake/lib/bb/tinfoil.py
@@ -65,6 +65,10 @@ class TinfoilDataStoreConnector:
         return set(self.tinfoil.run_command('dataStoreConnectorGetKeys', self.dsindex))
     def getVarHistory(self, name):
         return self.tinfoil.run_command('dataStoreConnectorGetVarHistory', self.dsindex, name)
+    def getOverrideData(self, name=None):
+        if name:
+            return self.tinfoil.run_command('dataStoreConnectorGetOverrideData', self.dsindex, name)
+        return self.tinfoil.run_command('dataStoreConnectorGetOverrideData', self.dsindex)
     def expandPythonRef(self, varname, expr, d):
         ds = bb.remotedata.RemoteDatastores.transmit_datastore(d)
         ret = self.tinfoil.run_command('dataStoreConnectorExpandPythonRef', ds, varname, expr)
-- 
2.7.4


