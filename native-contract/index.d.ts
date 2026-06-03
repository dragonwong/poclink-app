export type PoclinkNativeApiVersion = "0.1.0";

export interface PoclinkInitConfig {
  dns: string;
  html: string;
  agent: string;
  development?: boolean;
  logEnabled?: boolean;
}

export interface PoclinkLoginResult {
  account: string;
  token?: string;
  regionId?: string;
  effectiveTime?: number;
}

export interface PoclinkServiceUrl {
  serverType: string;
  regionName?: string;
  serverUrl: string;
}

export interface PoclinkVoiceLoginResult {
  success: boolean;
  code: number;
}

export interface PoclinkUser {
  uid: string;
  name?: string;
  account?: string;
}

export interface PoclinkGroup {
  gid: string;
  name?: string;
}

export interface PoclinkJoinGroupParams {
  gid: string;
  contactId?: string | null;
  token?: string | null;
  isLimit?: "0" | "1";
}

export interface PoclinkSpeakParams {
  groupPost?: boolean;
}

export interface PoclinkNativeModule {
  getNativeApiVersion(): Promise<PoclinkNativeApiVersion>;
  initialize(config: PoclinkInitConfig): Promise<void>;
  emailLogin(params: { account: string; passwordMd5: string }): Promise<PoclinkLoginResult>;
  googleAuth(params: { idToken: string; email: string; name?: string }): Promise<PoclinkLoginResult>;
  checkEmailAccount(params: { account: string }): Promise<{ exists?: boolean; code?: number; message?: string }>;
  checkGoogleAccount(params: { idToken: string; type: number }): Promise<{ exists?: boolean; code?: number; message?: string }>;
  getServiceUrl(params: { account: string }): Promise<PoclinkServiceUrl[]>;
  setServiceUrl(params: { urls: PoclinkServiceUrl[] }): Promise<void>;
  voiceLogin(params: { account: string }): Promise<PoclinkVoiceLoginResult>;
  getCurrentUser(): Promise<PoclinkUser | null>;
  getCurrentGroup(): Promise<PoclinkGroup | null>;
  joinGroup(params: PoclinkJoinGroupParams): Promise<{ code: number }>;
  startSpeak(params?: PoclinkSpeakParams): Promise<{ code: number }>;
  stopSpeak(): Promise<void>;
}

export type PoclinkNativeEventName =
  | "poclink.login"
  | "poclink.groupChanged"
  | "poclink.speaking"
  | "poclink.session"
  | "poclink.error"
  | "poclink.rawNotification";

export interface PoclinkNativeEventPayloads {
  "poclink.login": {
    type: "success" | "otherLogin" | "tokenInvalid";
    user?: PoclinkUser;
    message?: string;
  };
  "poclink.groupChanged": {
    type: "currentChanged" | "listChanged" | "removed" | "joinDenied";
    group?: PoclinkGroup;
    gids?: string[];
    message?: string;
  };
  "poclink.speaking": {
    type: "selfStart" | "selfStop" | "memberStart" | "memberStop" | "micGranted" | "micLost";
    gid?: string;
    uid?: string;
    name?: string;
    talkLength?: string;
    success?: boolean;
  };
  "poclink.session": {
    type: "start" | "response" | "stop" | "audioStartPlay" | "audioStartRecord";
    reason?: string;
    data?: Record<string, unknown>;
  };
  "poclink.error": {
    code: string;
    message: string;
    nativeName?: string;
    data?: unknown;
  };
  "poclink.rawNotification": {
    name: string;
    data?: unknown;
  };
}
